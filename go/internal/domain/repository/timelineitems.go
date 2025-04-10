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

	SetError(key string, err error)
	ClearError(key string)
}
