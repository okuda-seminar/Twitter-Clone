package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type unblockUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUnblockUserUsecase(usersRepository repository.UsersRepository) usecase.UnblockUserUsecase {
	return &unblockUserUsecase{usersRepository: usersRepository}
}

func (u *unblockUserUsecase) UnblockUser(sourceUserID, targetUserID string) error {
	err := u.usersRepository.UnblockUser(nil, sourceUserID, targetUserID)
	if errors.Is(err, repository.ErrRecordNotFound) {
		return usecase.ErrBlockNotFound
	}

	return err
}

func (u *unblockUserUsecase) SetError(err error) {}
func (u *unblockUserUsecase) ClearError()        {}
