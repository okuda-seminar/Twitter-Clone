package usecase

import (
	"x-clone-backend/internal/domain/entity"
)

type GetUserAndFolloweePostsUsecase interface {
	GetUserAndFolloweePosts(userID string) ([]*entity.Post, error)
}
