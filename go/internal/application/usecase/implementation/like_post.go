package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type likePostUsecase struct {
	usersRepository repository.UsersRepository
}

func NewLikePostUsecase(usersRepository repository.UsersRepository) usecase.LikePostUsecase {
	return &likePostUsecase{usersRepository: usersRepository}
}

func (u *likePostUsecase) LikePost(userID string, postID string) error {
	err := u.usersRepository.LikePost(nil, userID, postID)
	return err
}
