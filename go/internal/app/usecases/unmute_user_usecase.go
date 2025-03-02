package usecases

import (
	"x-clone-backend/internal/domain/repositories"
)

type UnmuteUserUsecase interface {
	UnmuteUser(sourceUserID, targetUserID string) error
}

type unmuteUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewUnmuteUserUsecase(usersRepository repositories.UsersRepositoryInterface) UnmuteUserUsecase {
	return &unmuteUserUsecase{usersRepository: usersRepository}
}

func (p *unmuteUserUsecase) UnmuteUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.UnmuteUser(nil, sourceUserID, targetUserID)
	return err
}
