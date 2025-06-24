package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeDeleteRepostUsecase struct {
	err error
}

func NewFakeDeleteRepostUsecase() usecase.DeleteRepostUsecase {
	return &fakeDeleteRepostUsecase{
		err: nil,
	}
}

func (u *fakeDeleteRepostUsecase) DeleteRepost(repostID string) (entity.TimelineItem, error) {
	return entity.TimelineItem{}, u.err
}

func (u *fakeDeleteRepostUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeDeleteRepostUsecase) ClearError() {
	u.err = nil
}
