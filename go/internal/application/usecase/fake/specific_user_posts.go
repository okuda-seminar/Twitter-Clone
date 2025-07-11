package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeSpecificUserPostsUsecase struct {
	err   error
	posts []*entity.TimelineItem
}

func NewFakeSpecificUserPostsUsecase() usecase.SpecificUserPostsUsecase {
	return &fakeSpecificUserPostsUsecase{
		err:   nil,
		posts: []*entity.TimelineItem{},
	}
}

func (u *fakeSpecificUserPostsUsecase) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	if u.err != nil {
		return nil, u.err
	}
	return u.posts, nil
}

func (u *fakeSpecificUserPostsUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeSpecificUserPostsUsecase) ClearError() {
	u.err = nil
}

func (u *fakeSpecificUserPostsUsecase) SetPosts(posts []*entity.TimelineItem) {
	u.posts = posts
}
