package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type likePostUsecase struct {
	usersRepository repository.UsersRepository
}

func NewLikePostUsecase(usersRepository repository.UsersRepository) usecase.LikePostUsecase {
	return &likePostUsecase{usersRepository: usersRepository}
}

func (p *likePostUsecase) LikePost(userID string, postID string) error {
	err := p.usersRepository.LikePost(nil, userID, postID)
	return err
}
