package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeDeletePostUsecase struct {
	err error
}

func NewFakeDeletePostUsecase() usecase.DeletePostUsecase {
	return &fakeDeletePostUsecase{
		err: nil,
	}
}

func (u *fakeDeletePostUsecase) DeletePost(postID string) (entity.TimelineItem, error) {
	return entity.TimelineItem{}, u.err
}

func (u *fakeDeletePostUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeDeletePostUsecase) ClearError() {
	u.err = nil
}
