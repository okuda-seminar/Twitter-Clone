package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type unlikePostUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUnlikePostUsecase(usersRepository repository.UsersRepository) usecase.UnlikePostUsecase {
	return &unlikePostUsecase{usersRepository: usersRepository}
}

func (p *unlikePostUsecase) UnlikePost(userID string, postID string) error {
	err := p.usersRepository.UnlikePost(nil, userID, postID)
	return err
}
