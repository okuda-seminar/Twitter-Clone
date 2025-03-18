package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type muteUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewMuteUserUsecase(usersRepository repository.UsersRepository) usecase.MuteUserUsecase {
	return &muteUserUsecase{usersRepository: usersRepository}
}

func (p *muteUserUsecase) MuteUser(sourceUserID, targetUserID string) error {
	err := p.usersRepository.MuteUser(nil, sourceUserID, targetUserID)
	return err
}
