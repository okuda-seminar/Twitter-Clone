package usecase

import (
	"github.com/google/uuid"

	"x-clone-backend/internal/domain/entity"
)

type CreatePostUsecase interface {
	CreatePost(userID uuid.UUID, text string) (entity.TimelineItem, error)
}
