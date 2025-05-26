package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type unlikePostUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUnlikePostUsecase(usersRepository repository.UsersRepository) usecase.UnlikePostUsecase {
	return &unlikePostUsecase{usersRepository: usersRepository}
}

func (u *unlikePostUsecase) UnlikePost(userID string, postID string) error {
	err := u.usersRepository.UnlikePost(nil, userID, postID)
	if errors.Is(err, repository.ErrRecordNotFound) {
		return usecase.ErrLikeNotFound
	}

	return err
}
