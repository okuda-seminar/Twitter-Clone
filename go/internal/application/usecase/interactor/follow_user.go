package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type followUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewFollowUserUsecase(usersRepository repository.UsersRepository) usecase.FollowUserUsecase {
	return &followUserUsecase{usersRepository: usersRepository}
}

func (p *followUserUsecase) FollowUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.FollowUser(nil, sourceUserID, targetUserID)
	return err
}
