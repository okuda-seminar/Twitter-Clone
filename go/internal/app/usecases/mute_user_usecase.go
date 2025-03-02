package usecases

import (
	"x-clone-backend/internal/domain/repositories"
)

type MuteUserUsecase interface {
	MuteUser(sourceUserID, targetUserID string) error
}

type muteUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewMuteUserUsecase(usersRepository repositories.UsersRepositoryInterface) MuteUserUsecase {
	return &muteUserUsecase{usersRepository: usersRepository}
}

func (p *muteUserUsecase) MuteUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.MuteUser(nil, sourceUserID, targetUserID)
	return err
}
