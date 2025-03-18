package usecase

import (
	"github.com/google/uuid"
)

type LikePostUsecase interface {
	LikePost(userID string, postID uuid.UUID) error
}
