package usecases

import (
	"x-clone-backend/internal/domain/repositories"
)

type UnlikePostUsecase interface {
	UnlikePost(userID string, postID string) error
}

type unlikePostUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewUnlikePostUsecase(usersRepository repositories.UsersRepositoryInterface) UnlikePostUsecase {
	return &unlikePostUsecase{usersRepository: usersRepository}
}

func (p *unlikePostUsecase) UnlikePost(userID string, postID string) error {
	err := p.usersRepository.UnlikePost(nil, userID, postID)
	return err
}
