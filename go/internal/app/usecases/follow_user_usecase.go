package usecases

import (
	"x-clone-backend/internal/domain/repositories"
)

type FollowUserUsecase interface {
	FollowUser(sourceUserID, targetUserID string) error
}

type followUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewFollowUserUsecase(usersRepository repositories.UsersRepositoryInterface) FollowUserUsecase {
	return &followUserUsecase{usersRepository: usersRepository}
}

func (p *followUserUsecase) FollowUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.FollowUser(nil, sourceUserID, targetUserID)
	return err
}
