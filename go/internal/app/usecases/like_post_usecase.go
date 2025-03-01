package usecases

import (
	"x-clone-backend/internal/domain/repositories"

	"github.com/google/uuid"
)

type LikePostUsecase interface {
	LikePost(userID string, postID uuid.UUID) error
}

type likePostUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewLikePostUsecase(usersRepository repositories.UsersRepositoryInterface) LikePostUsecase {
	return &likePostUsecase{usersRepository: usersRepository}
}

func (p *likePostUsecase) LikePost(userID string, postID uuid.UUID) error {
	err := p.usersRepository.LikePost(nil, userID, postID)
	return err
}
