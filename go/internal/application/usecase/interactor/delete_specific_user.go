package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type deleteUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewDeleteUserUsecase(usersRepository repository.UsersRepository) usecase.DeleteUserUsecase {
	return &deleteUserUsecase{usersRepository: usersRepository}
}

func (p *deleteUserUsecase) DeleteUser(userID string) error {
	err := p.usersRepository.DeleteUser(nil, userID)
	return err
}
