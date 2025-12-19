package implementation

import (
	"database/sql"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/cache"
	"x-clone-backend/internal/infrastructure/rdb"
)

type timelineItemsRepository struct {
	cacheRepo cache.CacheTimelineItemsRepository
	rdbRepo   rdb.RDBTimelineItemsRepository
}

func NewTimelineItemsRepository(cacheRepo cache.CacheTimelineItemsRepository, rdbRepo rdb.RDBTimelineItemsRepository) repository.TimelineItemsRepository {
	return timelineItemsRepository{
		cacheRepo: cacheRepo,
		rdbRepo:   rdbRepo,
	}
}

func (r timelineItemsRepository) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	item, err := r.rdbRepo.SpecificUserPosts(userID)
	return item, err
}

// UserAndFolloweePosts retrieves timeline items for a user and their followees.
// It first fetches post IDs from the cache repository and then retrieves the corresponding timeline items from the RDB repository.
// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/875
// Implement cache server down handling
func (r timelineItemsRepository) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
	postIDs, err := r.cacheRepo.UserAndFolloweePosts(userID)
	if err != nil {
		return r.rdbRepo.UserAndFolloweePosts(nil, userID)
	}

	if len(postIDs) == 0 {
		return []*entity.TimelineItem{}, nil
	}

	// Fetch timeline items from RDB using the retrieved post IDs
	// Retrieveving postIDs from cache accerates the process of query execution in RDB,
	// because RDB only needs to handle specific postIDs instead of joining with follow table.
	items, err := r.rdbRepo.PostsByIDs(nil, postIDs)
	return items, err
}

func (r timelineItemsRepository) CreatePost(userID, text string, userIDs []string) (entity.TimelineItem, error) {
	var post entity.TimelineItem
	txErr := r.rdbRepo.WithTransaction(func(tx *sql.Tx) error {
		var err error
		post, err = r.rdbRepo.CreatePost(tx, userID, text)
		if err != nil {
			return err
		}

		err = r.cacheRepo.CreatePost(post.ID, userIDs, float64(post.CreatedAt.UnixMilli()))
		if err != nil {
			return err
		}
		return nil
	})
	if txErr != nil {
		return entity.TimelineItem{}, txErr
	}
	return post, nil
}

func (r timelineItemsRepository) DeletePost(postID string) error {
	err := r.rdbRepo.DeletePost(postID)
	return err
}

// CreateRepost creates a repost and updates the timeline cache for the given user IDs.
// userIDs is the list of users who should see this repost in their timeline (the author and their followers).
func (r timelineItemsRepository) CreateRepost(userID, postID string, userIDs []string) (entity.TimelineItem, error) {
	var repost entity.TimelineItem
	txErr := r.rdbRepo.WithTransaction(func(tx *sql.Tx) error {
		var err error
		repost, err = r.rdbRepo.CreateRepost(tx, userID, postID)
		if err != nil {
			return err
		}

		err = r.cacheRepo.CreateRepost(repost.ID, userIDs, float64(repost.CreatedAt.UnixMilli()))
		if err != nil {
			return err
		}
		return nil
	})

	if txErr != nil {
		return entity.TimelineItem{}, txErr
	}

	return repost, nil
}

func (r timelineItemsRepository) DeleteRepost(postID string) error {
	err := r.rdbRepo.DeleteRepost(postID)
	return err
}

// CreateQuoteRepost creates a quote repost and updates the timeline cache for the given user IDs.
// userIDs is the list of users who should see this quote repost in their timeline (the author and their followers).
func (r timelineItemsRepository) CreateQuoteRepost(userID, postID, text string, userIDs []string) (entity.TimelineItem, error) {
	var quoteRepost entity.TimelineItem
	txErr := r.rdbRepo.WithTransaction(func(tx *sql.Tx) error {
		var err error
		quoteRepost, err = r.rdbRepo.CreateQuoteRepost(tx, userID, postID, text)
		if err != nil {
			return err
		}

		err = r.cacheRepo.CreateQuoteRepost(quoteRepost.ID, userIDs, float64(quoteRepost.CreatedAt.UnixMilli()))
		if err != nil {
			return err
		}
		return nil
	})
	if txErr != nil {
		return entity.TimelineItem{}, txErr
	}
	return quoteRepost, nil
}

func (r timelineItemsRepository) TimelineItemByID(postID string) (*entity.TimelineItem, error) {
	timelineItem, err := r.rdbRepo.TimelineItemByID(postID)
	return timelineItem, err
}

// These methods are only used in the fake implementation for testing and are unused here.
func (r timelineItemsRepository) SetError(key string, err error) {}
func (r timelineItemsRepository) ClearError(key string)          {}
