package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type getUserAndFolloweePostsUsecase struct {
	postsRepository repository.PostsRepository
}

func NewGetUserAndFolloweePostsUsecase(postsRepository repository.PostsRepository) usecase.GetUserAndFolloweePostsUsecase {
	return &getUserAndFolloweePostsUsecase{postsRepository: postsRepository}
}

func (p *getUserAndFolloweePostsUsecase) GetUserAndFolloweePosts(userID string) ([]*entity.Post, error) {
	posts, err := p.postsRepository.GetUserAndFolloweePosts(userID)
	if err != nil {
		return nil, err
	}

	return posts, nil
}
