package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeGetFollowersByIDUsecase struct {
	followers []entity.User
	err       error
}

func NewFakeGetFollowersByIDUsecase() usecase.GetFollowersByIDUsecase {
	return &fakeGetFollowersByIDUsecase{}
}

func (u *fakeGetFollowersByIDUsecase) GetFollowersByID(userID string) ([]entity.User, error) {
	if u.err != nil {
		return nil, u.err
	}
	return u.followers, nil
}

func (u *fakeGetFollowersByIDUsecase) SetFollowers(followers []entity.User) {
	u.followers = followers
}

func (u *fakeGetFollowersByIDUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeGetFollowersByIDUsecase) ClearError() {
	u.err = nil
}
