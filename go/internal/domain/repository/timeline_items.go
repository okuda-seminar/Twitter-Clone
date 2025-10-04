package repository

import "x-clone-backend/internal/domain/entity"

type TimelineItemsRepository interface {
	SpecificUserPosts(userID string) ([]*entity.TimelineItem, error)
	UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error)
	CreatePost(userID, text string, userIDs []string) (entity.TimelineItem, error)
	DeletePost(postID string) (entity.TimelineItem, error)
	CreateRepost(userID, postID string) (entity.TimelineItem, error)
	DeleteRepost(postID string) (entity.TimelineItem, error)
	CreateQuoteRepost(userID, postID, text string, userIDs []string) (entity.TimelineItem, error)
	TimelineItemByID(postID string) (*entity.TimelineItem, error)

	// These methods are used to set or clear simulated operation-specific errors in tests.
	SetError(key string, err error)
	ClearError(key string)
}
