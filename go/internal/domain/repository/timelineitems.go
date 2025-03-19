package repository

import (
	"x-clone-backend/internal/domain/entity"
)

type TimelineItemsRepository interface {
	SpecificUserPosts(userID string) ([]*entity.TimelineItem, error)
	UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error)
}
