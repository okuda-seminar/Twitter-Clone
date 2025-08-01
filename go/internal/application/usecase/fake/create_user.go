package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeCreateUserUsecase struct {
	err  error
	user entity.User
}

func NewFakeCreateUserUsecase() usecase.CreateUserUsecase {
	return &fakeCreateUserUsecase{
		err:  nil,
		user: entity.User{},
	}
}

func (u *fakeCreateUserUsecase) CreateUser(username, displayName, password string) (entity.User, error) {
	if u.err != nil {
		return entity.User{}, u.err
	}
	return u.user, nil
}

func (u *fakeCreateUserUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeCreateUserUsecase) ClearError() {
	u.err = nil
}

func (u *fakeCreateUserUsecase) SetUser(user entity.User) {
	u.user = user
}

func (u *fakeCreateUserUsecase) ClearUser() {
	u.user = entity.User{}
}
