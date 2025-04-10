package repository

import (
	"x-clone-backend/internal/domain/entity"
)

type TimelineItemsRepository interface {
	SpecificUserPosts(userID string) ([]*entity.TimelineItem, error)
	UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error)
	CreatePost(userID, text string) (entity.TimelineItem, error)
	DeletePost(postID string) error
	CreateRepost(userID, postID string) (entity.TimelineItem, error)
	DeleteRepost(postID string) error
	CreateQuoteRepost(userID, postID, text string) (entity.TimelineItem, error)

	// These methods are used to set or clear simulated operation-specific errors in tests.
	SetError(key string, err error)
	ClearError(key string)
}
