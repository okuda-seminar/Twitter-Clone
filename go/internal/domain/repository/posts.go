package repository

import (
	"x-clone-backend/internal/domain/entity"
)

type PostsRepository interface {
	GetSpecificUserPosts(userID string) ([]*entity.Post, error)
	GetUserAndFolloweePosts(userID string) ([]*entity.Post, error)
}
