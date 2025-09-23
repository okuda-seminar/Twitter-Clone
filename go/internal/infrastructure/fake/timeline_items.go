package fake

import (
	"sync"
	"time"

	"github.com/google/uuid"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/domain/value"
)

type fakeTimelineitemsRepository struct {
	mu            sync.RWMutex
	timelineItems map[string]*entity.TimelineItem

	errors map[string]error
}

func NewFakeTimelineItemsRepository() repository.TimelineItemsRepository {
	return &fakeTimelineitemsRepository{
		mu:            sync.RWMutex{},
		timelineItems: make(map[string]*entity.TimelineItem),

		errors: make(map[string]error),
	}
}

func (r *fakeTimelineitemsRepository) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if err, ok := r.errors[repository.ErrKeySpecificUserPosts]; ok {
		return []*entity.TimelineItem{}, err
	}

	timelineItems := []*entity.TimelineItem{}
	for _, item := range r.timelineItems {
		if item.AuthorID == userID {
			timelineItems = append(timelineItems, item)
		}
	}

	return timelineItems, nil
}

// UserAndFolloweePosts returns all timeline items without filtering by followee.
// This is a limitation of the fake repository used for testing,
// as it does not have access to follow relationships, which are managed by the users repository.
//
// In a real implementation, this method would return posts by the given user　and their followees,
// but here we simply return all timeline items to simulate behavior.
func (r *fakeTimelineitemsRepository) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if err, ok := r.errors[repository.ErrKeyUserAndFolloweePosts]; ok {
		return []*entity.TimelineItem{}, err
	}

	var timelineItems []*entity.TimelineItem
	for _, item := range r.timelineItems {
		timelineItems = append(timelineItems, item)
	}

	return timelineItems, nil
}

// CreatePost creates and stores a new post by the given userID with the provided text in the in-memory database.
// If a preconfigured error for CreatePost exists, it returns the error without creating a post.
// Otherwise, it returns the created TimelineItem.
func (r *fakeTimelineitemsRepository) CreatePost(userID string, text string) (entity.TimelineItem, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors[repository.ErrKeyCreatePost]; ok {
		return entity.TimelineItem{}, err
	}

	postID := uuid.NewString()
	timelineItem := entity.TimelineItem{
		Type:      entity.PostTypePost,
		ID:        postID,
		AuthorID:  userID,
		Text:      text,
		CreatedAt: time.Now(),
	}
	r.timelineItems[postID] = &timelineItem

	return timelineItem, nil
}

func (r *fakeTimelineitemsRepository) DeletePost(postID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors[repository.ErrKeyDeletePost]; ok {
		return err
	}

	_, ok := r.timelineItems[postID]
	if !ok {
		return repository.ErrRecordNotFound
	}

	delete(r.timelineItems, postID)

	return nil
}

func (r *fakeTimelineitemsRepository) CreateRepost(userID, postID string) (entity.TimelineItem, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors[repository.ErrKeyCreateRepost]; ok {
		return entity.TimelineItem{}, err
	}

	if _, ok := r.timelineItems[postID]; !ok {
		return entity.TimelineItem{}, repository.ErrRecordNotFound
	}

	parentPost := *r.timelineItems[postID]

	if isRepostUniqueViolation(parentPost, postID, value.NullUUID{UUID: postID, Valid: true}) {
		return entity.TimelineItem{}, repository.ErrUniqueViolation
	}

	repostID := uuid.NewString()
	timelineItem := entity.TimelineItem{
		Type:         entity.PostTypeRepost,
		ID:           repostID,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: postID, Valid: true},
		Text:         "",
		CreatedAt:    time.Now(),
	}

	r.timelineItems[repostID] = &timelineItem

	return timelineItem, nil
}

func (r *fakeTimelineitemsRepository) DeleteRepost(postID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors[repository.ErrKeyDeleteRepost]; ok {
		return err
	}

	_, ok := r.timelineItems[postID]
	if !ok {
		return repository.ErrRecordNotFound
	}

	delete(r.timelineItems, postID)

	return nil
}

func (r *fakeTimelineitemsRepository) CreateQuoteRepost(userID, postID, text string) (entity.TimelineItem, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors[repository.ErrKeyCreateQuoteRepost]; ok {
		return entity.TimelineItem{}, err
	}

	if _, ok := r.timelineItems[postID]; !ok {
		return entity.TimelineItem{}, repository.ErrRecordNotFound
	}

	quoteRepostID := uuid.NewString()
	timelineItem := entity.TimelineItem{
		Type:         entity.PostTypeQuoteRepost,
		ID:           quoteRepostID,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: postID, Valid: true},
		Text:         text,
		CreatedAt:    time.Now(),
	}
	r.timelineItems[quoteRepostID] = &timelineItem

	return timelineItem, nil
}

func (r *fakeTimelineitemsRepository) TimelineItemByID(postID string) (*entity.TimelineItem, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if err, ok := r.errors[repository.ErrKeyRetrieveTimelineItem]; ok {
		return &entity.TimelineItem{}, err
	}

	item, ok := r.timelineItems[postID]
	if !ok {
		return &entity.TimelineItem{}, repository.ErrRecordNotFound
	}

	return item, nil
}

func (r *fakeTimelineitemsRepository) SetError(key string, err error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	r.errors[key] = err
}

func (r *fakeTimelineitemsRepository) ClearError(key string) {
	r.mu.Lock()
	defer r.mu.Unlock()

	delete(r.errors, key)
}

func isRepostUniqueViolation(item entity.TimelineItem, userUUID string, postNullUUID value.NullUUID) bool {
	return item.Type == entity.PostTypeRepost && item.AuthorID == userUUID && item.ParentPostID == postNullUUID
}
