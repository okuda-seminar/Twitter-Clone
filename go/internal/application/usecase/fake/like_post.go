package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeLikePostUsecase struct {
	err error
}

func NewFakeLikePostUsecase() usecase.LikePostUsecase {
	return &fakeLikePostUsecase{
		err: nil,
	}
}

func (u *fakeLikePostUsecase) LikePost(userID string, postID string) error {
	if u.err != nil {
		return u.err
	}
	return nil
}

func (u *fakeLikePostUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeLikePostUsecase) ClearError() {
	u.err = nil
}
