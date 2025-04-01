package interactor

import (
	"errors"

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
	if errors.Is(err, repository.ErrRecordNotFound) {
		return usecase.ErrFollowshipNotFound
	}

	return err
}
