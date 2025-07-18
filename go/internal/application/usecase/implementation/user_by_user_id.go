package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type userByUserIDUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUserByUserIDUsecase(usersRepository repository.UsersRepository) usecase.UserByUserIDUsecase {
	return &userByUserIDUsecase{usersRepository}
}

func (u *userByUserIDUsecase) UserByUserID(userID string) (entity.User, error) {
	user, err := u.usersRepository.UserByUserID(nil, userID)
	if err != nil {
		return entity.User{}, err
	}

	return user, nil
}

func (u *userByUserIDUsecase) SetError(err error)  {}
func (u *userByUserIDUsecase) ClearError()         {}
func (u *userByUserIDUsecase) SetUser(entity.User) {}
