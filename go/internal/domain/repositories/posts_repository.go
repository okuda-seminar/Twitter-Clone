package repositories

import (
	"x-clone-backend/internal/domain/entities"
)

type PostsRepositoryInterface interface {
	GetSpecificUserPosts(userID string) ([]*entities.Post, error)
	GetUserAndFolloweePosts(userID string) ([]*entities.Post, error)
}
