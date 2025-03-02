package usecases

import (
	"database/sql"
	"x-clone-backend/internal/app/errors"
	"x-clone-backend/internal/domain/repositories"
)

type BlockUserUsecase interface {
	BlockUser(sourceUserID, targetUserID string) error
}

type blockUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewBlockUserUsecase(usersRepository repositories.UsersRepositoryInterface) BlockUserUsecase {
	return &blockUserUsecase{usersRepository: usersRepository}
}

func (p *blockUserUsecase) BlockUser(sourceUserID, targetUserID string) error {
	return p.usersRepository.WithTransaction(func(tx *sql.Tx) error {
		if err := p.usersRepository.BlockUser(tx, sourceUserID, targetUserID); err != nil {
			return err
		}
		if err := p.usersRepository.UnfollowUser(tx, sourceUserID, targetUserID); err != nil {
			if err != errors.ErrFollowshipNotFound {
				return err
			}
		}
		if err := p.usersRepository.UnfollowUser(tx, targetUserID, sourceUserID); err != nil {
			if err != errors.ErrFollowshipNotFound {
				return err
			}
		}
		if err := p.usersRepository.UnmuteUser(tx, sourceUserID, targetUserID); err != nil {
			if err != errors.ErrMuteNotFound {
				return err
			}
		}
		return nil
	})
}
