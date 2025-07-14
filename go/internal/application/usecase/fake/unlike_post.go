package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeUnlikePostUsecase struct {
	err error
}

func NewFakeUnlikePostUsecase() usecase.UnlikePostUsecase {
	return &fakeUnlikePostUsecase{
		err: nil,
	}
}

func (u *fakeUnlikePostUsecase) UnlikePost(userID, postID string) error {
	if u.err != nil {
		return u.err
	}
	return nil
}

func (u *fakeUnlikePostUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeUnlikePostUsecase) ClearError() {
	u.err = nil
}
