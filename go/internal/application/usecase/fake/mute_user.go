package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeMuteUserUsecase struct {
	err error
}

func NewFakeMuteUserUsecase() usecase.MuteUserUsecase {
	return &fakeMuteUserUsecase{
		err: nil,
	}
}

func (u *fakeMuteUserUsecase) MuteUser(sourceUserID, targetUserID string) error {
	if u.err != nil {
		return u.err
	}
	return nil
}

func (u *fakeMuteUserUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeMuteUserUsecase) ClearError() {
	u.err = nil
}
