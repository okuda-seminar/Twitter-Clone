package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type deleteUserByIDUsecase struct {
	usersRepository repository.UsersRepository
}

func NewDeleteUserByIDUsecase(usersRepository repository.UsersRepository) usecase.DeleteUserByIDUsecase {
	return &deleteUserByIDUsecase{
		usersRepository,
	}
}

func (u *deleteUserByIDUsecase) DeleteUserByID(userID string) error {
	err := u.usersRepository.DeleteUserByID(nil, userID)
	if errors.Is(err, repository.ErrRecordNotFound) {
		return usecase.ErrUserNotFound
	}

	return err
}

func (u *deleteUserByIDUsecase) SetError(err error) {}
func (u *deleteUserByIDUsecase) ClearError()        {}
