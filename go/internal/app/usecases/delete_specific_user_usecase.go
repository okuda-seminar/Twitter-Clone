package usecases

import (
	"x-clone-backend/internal/domain/repositories"
)

type DeleteUserUsecase interface {
	DeleteUser(userID string) error
}

type deleteUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewDeleteUserUsecase(usersRepository repositories.UsersRepositoryInterface) DeleteUserUsecase {
	return &deleteUserUsecase{usersRepository: usersRepository}
}

func (p *deleteUserUsecase) DeleteUser(userID string) error {
	err := p.usersRepository.DeleteUser(nil, userID)
	return err
}
