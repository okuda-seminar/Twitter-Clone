package usecases

import (
	"x-clone-backend/internal/domain/entities"
	"x-clone-backend/internal/domain/repositories"
)

type GetUserAndFolloweePostsUsecase interface {
	GetUserAndFolloweePosts(userID string) ([]*entities.Post, error)
}

type getUserAndFolloweePostsUsecase struct {
	postsRepository repositories.PostsRepositoryInterface
}

func NewGetUserAndFolloweePostsUsecase(postsRepository repositories.PostsRepositoryInterface) GetUserAndFolloweePostsUsecase {
	return &getUserAndFolloweePostsUsecase{postsRepository: postsRepository}
}

func (p *getUserAndFolloweePostsUsecase) GetUserAndFolloweePosts(userID string) ([]*entities.Post, error) {
	posts, err := p.postsRepository.GetUserAndFolloweePosts(userID)
	if err != nil {
		return nil, err
	}

	return posts, nil
}
