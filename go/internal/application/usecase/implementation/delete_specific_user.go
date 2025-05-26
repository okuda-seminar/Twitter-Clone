package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type deleteUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewDeleteUserUsecase(usersRepository repository.UsersRepository) usecase.DeleteUserUsecase {
	return &deleteUserUsecase{usersRepository: usersRepository}
}

func (u *deleteUserUsecase) DeleteUser(userID string) error {
	err := u.usersRepository.DeleteUser(nil, userID)
	if errors.Is(err, repository.ErrRecordNotFound) {
		return usecase.ErrUserNotFound
	}

	return err
}
