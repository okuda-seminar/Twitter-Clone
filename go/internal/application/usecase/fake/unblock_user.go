package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeUnblockUserUsecase struct {
	err error
}

func NewFakeUnblockUserUsecase() usecase.UnblockUserUsecase {
	return &fakeUnblockUserUsecase{
		err: nil,
	}
}

func (u *fakeUnblockUserUsecase) UnblockUser(sourceUserID, targetUserID string) error {
	if u.err != nil {
		return u.err
	}

	return nil
}

func (u *fakeUnblockUserUsecase) SetError(err error) {
	u.err = err
}
func (u *fakeUnblockUserUsecase) ClearError() {
	u.err = nil
}
