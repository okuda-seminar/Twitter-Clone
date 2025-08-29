package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeGetFolloweesByIDUsecase struct {
	followees []entity.User
	err       error
}

func NewFakeGetFolloweesByIDUsecase() usecase.GetFolloweesByIDUsecase {
	return &fakeGetFolloweesByIDUsecase{}
}

func (u *fakeGetFolloweesByIDUsecase) GetFolloweesByID(userID string) ([]entity.User, error) {
	if u.err != nil {
		return nil, u.err
	}
	return u.followees, nil
}

func (u *fakeGetFolloweesByIDUsecase) SetFollowees(followees []entity.User) {
	u.followees = followees
}

func (u *fakeGetFolloweesByIDUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeGetFolloweesByIDUsecase) ClearError() {
	u.err = nil
}
