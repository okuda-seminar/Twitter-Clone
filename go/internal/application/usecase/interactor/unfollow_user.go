package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type unfollowUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUnfollowUserUsecase(usersRepository repository.UsersRepository) usecase.UnfollowUserUsecase {
	return &unfollowUserUsecase{usersRepository: usersRepository}
}

func (p *unfollowUserUsecase) UnfollowUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.UnfollowUser(nil, sourceUserID, targetUserID)
	return err
}
