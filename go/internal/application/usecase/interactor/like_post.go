package interactor

import (
	"github.com/google/uuid"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/repository"
)

type likePostUsecase struct {
	usersRepository repository.UsersRepository
}

func NewLikePostUsecase(usersRepository repository.UsersRepository) usecase.LikePostUsecase {
	return &likePostUsecase{usersRepository: usersRepository}
}

func (p *likePostUsecase) LikePost(userID string, postID uuid.UUID) error {
	err := p.usersRepository.LikePost(nil, userID, postID)
	return err
}
