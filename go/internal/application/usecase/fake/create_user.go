package fake

import (
	"github.com/google/uuid"

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

	u.user = entity.User{
		ID:          uuid.NewString(),
		Username:    username,
		DisplayName: displayName,
		Password:    password,
	}

	return u.user, nil
}

func (u *fakeCreateUserUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeCreateUserUsecase) ClearError() {
	u.err = nil
}
