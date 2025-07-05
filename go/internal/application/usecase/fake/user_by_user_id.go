package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeUserByUserIDUsecase struct {
	err  error
	user entity.User
}

func NewFakeUserByUserIDUsecase() usecase.UserByUserIDUsecase {
	return &fakeUserByUserIDUsecase{
		err:  nil,
		user: entity.User{},
	}
}

func (u *fakeUserByUserIDUsecase) UserByUserID(userID string) (entity.User, error) {
	if u.err != nil {
		return entity.User{}, u.err
	}
	return u.user, nil
}

func (u *fakeUserByUserIDUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeUserByUserIDUsecase) ClearError() {
	u.err = nil
}

func (u *fakeUserByUserIDUsecase) SetUser(user entity.User) {
	u.user = user
}
