package interactor

import (
	"database/sql"
	"errors"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type blockUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewBlockUserUsecase(usersRepository repository.UsersRepository) usecase.BlockUserUsecase {
	return &blockUserUsecase{usersRepository: usersRepository}
}

func (p *blockUserUsecase) BlockUser(sourceUserID, targetUserID string) error {
	return p.usersRepository.WithTransaction(func(tx *sql.Tx) error {
		if err := p.usersRepository.BlockUser(tx, sourceUserID, targetUserID); err != nil {
			return err
		}
		if err := p.usersRepository.UnfollowUser(tx, sourceUserID, targetUserID); err != nil {
			if !errors.Is(err, repository.ErrRecordNotFound) {
				return err
			}
		}
		if err := p.usersRepository.UnfollowUser(tx, targetUserID, sourceUserID); err != nil {
			if !errors.Is(err, repository.ErrRecordNotFound) {
				return err
			}
		}
		if err := p.usersRepository.UnmuteUser(tx, sourceUserID, targetUserID); err != nil {
			if !errors.Is(err, repository.ErrRecordNotFound) {
				return err
			}
		}
		return nil
	})
}
