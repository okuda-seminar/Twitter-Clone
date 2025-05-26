package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type muteUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewMuteUserUsecase(usersRepository repository.UsersRepository) usecase.MuteUserUsecase {
	return &muteUserUsecase{usersRepository: usersRepository}
}

func (u *muteUserUsecase) MuteUser(sourceUserID, targetUserID string) error {
	err := u.usersRepository.MuteUser(nil, sourceUserID, targetUserID)
	return err
}
