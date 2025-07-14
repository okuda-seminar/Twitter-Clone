package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeBlockUserUsecase struct {
	err error
}

func NewFakeBlockUserUsecase() usecase.BlockUserUsecase {
	return &fakeBlockUserUsecase{
		err: nil,
	}
}

func (u *fakeBlockUserUsecase) BlockUser(sourceUserID, targetUserID string) error {
	if u.err != nil {
		return u.err
	}

	return nil
}

func (u *fakeBlockUserUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeBlockUserUsecase) ClearError() {
	u.err = nil
}
