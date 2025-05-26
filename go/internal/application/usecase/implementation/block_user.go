package implementation

import (
	"database/sql"
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type blockUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewBlockUserUsecase(usersRepository repository.UsersRepository) usecase.BlockUserUsecase {
	return &blockUserUsecase{usersRepository: usersRepository}
}

func (u *blockUserUsecase) BlockUser(sourceUserID, targetUserID string) error {
	return u.usersRepository.WithTransaction(func(tx *sql.Tx) error {
		if err := u.usersRepository.BlockUser(tx, sourceUserID, targetUserID); err != nil {
			return err
		}
		if err := u.usersRepository.UnfollowUser(tx, sourceUserID, targetUserID); err != nil {
			if !errors.Is(err, repository.ErrRecordNotFound) {
				return err
			}
		}
		if err := u.usersRepository.UnfollowUser(tx, targetUserID, sourceUserID); err != nil {
			if !errors.Is(err, repository.ErrRecordNotFound) {
				return err
			}
		}
		if err := u.usersRepository.UnmuteUser(tx, sourceUserID, targetUserID); err != nil {
			if !errors.Is(err, repository.ErrRecordNotFound) {
				return err
			}
		}
		return nil
	})
}
