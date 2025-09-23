package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeDeletePostUsecase struct {
	err error
}

func NewFakeDeletePostUsecase() usecase.DeletePostUsecase {
	return &fakeDeletePostUsecase{
		err: nil,
	}
}

func (u *fakeDeletePostUsecase) DeletePost(postID string) error {
	return u.err
}

func (u *fakeDeletePostUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeDeletePostUsecase) ClearError() {
	u.err = nil
}
