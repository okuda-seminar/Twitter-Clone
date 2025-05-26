package api

import (
	"x-clone-backend/internal/domain/entity"
)

type CreatePostUsecase interface {
	CreatePost(userID, text string) (entity.TimelineItem, error)
}
