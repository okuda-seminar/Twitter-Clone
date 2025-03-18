package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type unblockUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUnblockUserUsecase(usersRepository repository.UsersRepository) usecase.UnblockUserUsecase {
	return &unblockUserUsecase{usersRepository: usersRepository}
}

func (p *unblockUserUsecase) UnblockUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.UnblockUser(nil, sourceUserID, targetUserID)
	return err
}
