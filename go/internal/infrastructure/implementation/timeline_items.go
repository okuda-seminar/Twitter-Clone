package implementation

import (
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

func (r timelineItemsRepository) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
	items, err := r.rdbRepo.UserAndFolloweePosts(userID)
	return items, err
}

func (r timelineItemsRepository) CreatePost(userID, text string) (entity.TimelineItem, error) {
	post, err := r.rdbRepo.CreatePost(userID, text)
	return post, err
}

func (r timelineItemsRepository) DeletePost(postID string) (entity.TimelineItem, error) {
	post, err := r.rdbRepo.DeletePost(postID)
	return post, err
}

func (r timelineItemsRepository) CreateRepost(userID, postID string) (entity.TimelineItem, error) {
	repost, err := r.rdbRepo.CreateRepost(userID, postID)
	return repost, err
}

func (r timelineItemsRepository) DeleteRepost(postID string) (entity.TimelineItem, error) {
	repost, err := r.rdbRepo.DeleteRepost(postID)
	return repost, err
}

func (r timelineItemsRepository) CreateQuoteRepost(userID, postID, text string) (entity.TimelineItem, error) {
	quoteRepost, err := r.rdbRepo.CreateQuoteRepost(userID, postID, text)
	return quoteRepost, err
}

func (r timelineItemsRepository) TimelineItemByID(postID string) (*entity.TimelineItem, error) {
	timelineItem, err := r.rdbRepo.TimelineItemByID(postID)
	return timelineItem, err
}

// These methods are only used in the fake implementation for testing and are unused here.
func (r timelineItemsRepository) SetError(key string, err error) {}
func (r timelineItemsRepository) ClearError(key string)          {}
