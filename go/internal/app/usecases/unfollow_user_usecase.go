package usecases

import (
	"x-clone-backend/internal/domain/repositories"
)

type UnfollowUserUsecase interface {
	UnfollowUser(sourceUserID, targetUserID string) error
}

type unfollowUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewUnfollowUserUsecase(usersRepository repositories.UsersRepositoryInterface) UnfollowUserUsecase {
	return &unfollowUserUsecase{usersRepository: usersRepository}
}

func (p *unfollowUserUsecase) UnfollowUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.UnfollowUser(nil, sourceUserID, targetUserID)
	return err
}
