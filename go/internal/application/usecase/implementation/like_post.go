package implementation

import (
	"errors"

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
	if err != nil {
		if errors.Is(err, repository.ErrForeignViolation) {
			return usecase.ErrUserOrPostNotFound
		}
		if errors.Is(err, repository.ErrUniqueViolation) {
			return usecase.ErrAlreadyLiked
		}
		return err
	}
	return nil
}

func (u *likePostUsecase) SetError(err error) {}
func (u *likePostUsecase) ClearError()        {}
