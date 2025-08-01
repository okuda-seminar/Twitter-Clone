package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type unmuteUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUnmuteUserUsecase(usersRepository repository.UsersRepository) usecase.UnmuteUserUsecase {
	return &unmuteUserUsecase{usersRepository: usersRepository}
}

func (u *unmuteUserUsecase) UnmuteUser(sourceUserID, targetUserID string) error {
	err := u.usersRepository.UnmuteUser(nil, sourceUserID, targetUserID)
	if errors.Is(err, repository.ErrRecordNotFound) {
		return usecase.ErrMuteNotFound
	}

	return err
}

func (u *unmuteUserUsecase) SetError(err error) {}
func (u *unmuteUserUsecase) ClearError()        {}
