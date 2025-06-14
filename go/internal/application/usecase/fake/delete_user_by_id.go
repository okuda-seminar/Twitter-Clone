package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
)

type fakeDeleteUserByIDUsecase struct {
	err error
}

func NewFakeDeleteUserByIDUsecase() usecase.DeleteUserByIDUsecase {
	return &fakeDeleteUserByIDUsecase{
		err: nil,
	}
}

func (u *fakeDeleteUserByIDUsecase) DeleteUserByID(userID string) error {
	if u.err != nil {
		return u.err
	}
	return nil
}

func (u *fakeDeleteUserByIDUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeDeleteUserByIDUsecase) ClearError() {
	u.err = nil
}
