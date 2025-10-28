package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeUserByUserIDUsecase struct {
	err         error
	userProfile entity.UserProfile
}

func NewFakeUserByUserIDUsecase() usecase.UserByUserIDUsecase {
	return &fakeUserByUserIDUsecase{
		err:         nil,
		userProfile: entity.UserProfile{},
	}
}

func (u *fakeUserByUserIDUsecase) UserByUserID(userID string) (user entity.UserProfile, err error) {
	if u.err != nil {
		return entity.UserProfile{}, u.err
	}
	return u.userProfile, nil
}

func (u *fakeUserByUserIDUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeUserByUserIDUsecase) ClearError() {
	u.err = nil
}

func (u *fakeUserByUserIDUsecase) SetUser(userProfile entity.UserProfile) {
	u.userProfile = userProfile
}
