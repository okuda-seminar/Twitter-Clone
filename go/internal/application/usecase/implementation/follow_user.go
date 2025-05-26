package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type followUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewFollowUserUsecase(usersRepository repository.UsersRepository) usecase.FollowUserUsecase {
	return &followUserUsecase{usersRepository: usersRepository}
}

func (u *followUserUsecase) FollowUser(sourceUserID, targetUserID string) error {
	err := u.usersRepository.FollowUser(nil, sourceUserID, targetUserID)
	return err
}
