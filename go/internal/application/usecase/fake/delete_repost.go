package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeDeleteRepostUsecase struct {
	err error
}

func NewFakeDeleteRepostUsecase() usecase.DeleteRepostUsecase {
	return &fakeDeleteRepostUsecase{
		err: nil,
	}
}

func (u *fakeDeleteRepostUsecase) DeleteRepost(repostID string) error {
	return u.err
}

func (u *fakeDeleteRepostUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeDeleteRepostUsecase) ClearError() {
	u.err = nil
}
