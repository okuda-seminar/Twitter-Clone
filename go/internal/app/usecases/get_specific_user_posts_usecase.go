package usecases

import (
	"x-clone-backend/internal/domain/entities"
	"x-clone-backend/internal/domain/repositories"
)

type GetSpecificUserPostsUsecase interface {
	GetSpecificUserPosts(userID string) ([]*entities.Post, error)
}

type getSpecificUserPostsUsecase struct {
	postsRepository repositories.PostsRepositoryInterface
}

func NewGetSpecificUserPostsUsecase(postsRepository repositories.PostsRepositoryInterface) GetSpecificUserPostsUsecase {
	return &getSpecificUserPostsUsecase{postsRepository: postsRepository}
}

func (p *getSpecificUserPostsUsecase) GetSpecificUserPosts(userID string) ([]*entities.Post, error) {
	posts, err := p.postsRepository.GetSpecificUserPosts(userID)
	if err != nil {
		return nil, err
	}

	return posts, nil
}
