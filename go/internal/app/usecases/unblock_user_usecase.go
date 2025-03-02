package usecases

import (
	"x-clone-backend/internal/domain/repositories"
)

type UnblockUserUsecase interface {
	UnblockUser(sourceUserID, targetUserID string) error
}

type unblockUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewUnblockUserUsecase(usersRepository repositories.UsersRepositoryInterface) UnblockUserUsecase {
	return &unblockUserUsecase{usersRepository: usersRepository}
}

func (p *unblockUserUsecase) UnblockUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.UnblockUser(nil, sourceUserID, targetUserID)
	return err
}
