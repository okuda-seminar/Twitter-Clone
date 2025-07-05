package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeSpecificUserPostsUsecase struct {
	err error
}

func NewFakeSpecificUserPostsUsecase() usecase.SpecificUserPostsUsecase {
	return &fakeSpecificUserPostsUsecase{
		err: nil,
	}
}

func (u *fakeSpecificUserPostsUsecase) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	if u.err != nil {
		return nil, u.err
	}
	return []*entity.TimelineItem{}, nil
}

func (u *fakeSpecificUserPostsUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeSpecificUserPostsUsecase) ClearError() {
	u.err = nil
}
