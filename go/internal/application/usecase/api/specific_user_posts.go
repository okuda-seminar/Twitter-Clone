package api

import (
	"x-clone-backend/internal/domain/entity"
)

type SpecificUserPostsUsecase interface {
	SpecificUserPosts(userID string) ([]*entity.TimelineItem, error)
}
