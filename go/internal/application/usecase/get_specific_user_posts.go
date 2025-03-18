package usecase

import (
	"x-clone-backend/internal/domain/entity"
)

type GetSpecificUserPostsUsecase interface {
	GetSpecificUserPosts(userID string) ([]*entity.Post, error)
}
