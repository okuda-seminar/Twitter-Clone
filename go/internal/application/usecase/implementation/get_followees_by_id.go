package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type getFolloweesByIDUsecase struct {
	usersRepository repository.UsersRepository
}

func NewGetFolloweesByIDUsecase(usersRepository repository.UsersRepository) usecase.GetFolloweesByIDUsecase {
	return &getFolloweesByIDUsecase{usersRepository: usersRepository}
}

func (u *getFolloweesByIDUsecase) GetFolloweesByID(userID string) ([]entity.User, error) {
	_, err := u.usersRepository.UserByUserID(nil, userID)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			return nil, usecase.ErrUserNotFound
		}
		return nil, err
	}

	followees, err := u.usersRepository.FolloweesByID(nil, userID)
	if err != nil {
		return nil, err
	}

	return followees, nil
}

func (u *getFolloweesByIDUsecase) SetFollowees(followees []entity.User) {}
func (u *getFolloweesByIDUsecase) SetError(err error)                   {}
func (u *getFolloweesByIDUsecase) ClearError()                          {}
