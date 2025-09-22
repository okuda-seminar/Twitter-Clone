package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type getFollowersByIDUsecase struct {
	usersRepository repository.UsersRepository
}

func NewGetFollowersByIDUsecase(usersRepository repository.UsersRepository) usecase.GetFollowersByIDUsecase {
	return &getFollowersByIDUsecase{usersRepository: usersRepository}
}

func (u *getFollowersByIDUsecase) GetFollowersByID(userID string) ([]entity.User, error) {
	_, err := u.usersRepository.UserByUserID(nil, userID)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			return nil, usecase.ErrUserNotFound
		}
		return nil, err
	}

	followers, err := u.usersRepository.FollowersByID(nil, userID)
	if err != nil {
		return nil, err
	}

	return followers, nil
}

func (u *getFollowersByIDUsecase) SetFollowers(followers []entity.User) {}
func (u *getFollowersByIDUsecase) SetError(err error)                   {}
func (u *getFollowersByIDUsecase) ClearError()                          {}
