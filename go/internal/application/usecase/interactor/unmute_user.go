package interactor

import (
	"errors"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type unmuteUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUnmuteUserUsecase(usersRepository repository.UsersRepository) usecase.UnmuteUserUsecase {
	return &unmuteUserUsecase{usersRepository: usersRepository}
}

func (p *unmuteUserUsecase) UnmuteUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.UnmuteUser(nil, sourceUserID, targetUserID)
	if errors.Is(err, repository.ErrRecordNotFound) {
		return usecase.ErrMuteNotFound
	}

	return err
}
