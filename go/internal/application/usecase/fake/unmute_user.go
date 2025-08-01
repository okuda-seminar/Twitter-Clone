package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeUnmuteUserUsecase struct {
	err error
}

func NewFakeUnmuteUserUsecase() usecase.UnmuteUserUsecase {
	return &fakeUnmuteUserUsecase{
		err: nil,
	}
}

func (u *fakeUnmuteUserUsecase) UnmuteUser(sourceUserID, targetUserID string) error {
	if u.err != nil {
		return u.err
	}

	return nil
}

func (u *fakeUnmuteUserUsecase) SetError(err error) {
	u.err = err
}
func (u *fakeUnmuteUserUsecase) ClearError() {
	u.err = nil
}
