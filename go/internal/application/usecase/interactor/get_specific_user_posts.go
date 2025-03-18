package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type getSpecificUserPostsUsecase struct {
	postsRepository repository.PostsRepository
}

func NewGetSpecificUserPostsUsecase(postsRepository repository.PostsRepository) usecase.GetSpecificUserPostsUsecase {
	return &getSpecificUserPostsUsecase{postsRepository: postsRepository}
}

func (p *getSpecificUserPostsUsecase) GetSpecificUserPosts(userID string) ([]*entity.Post, error) {
	posts, err := p.postsRepository.GetSpecificUserPosts(userID)
	if err != nil {
		return nil, err
	}

	return posts, nil
}
