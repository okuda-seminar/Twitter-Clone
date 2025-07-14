package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeUserAndFolloweePostsUsecase struct {
	err           error
	timelineItems []*entity.TimelineItem
}

func NewFakeUserAndFolloweePostsUsecase() usecase.UserAndFolloweePostsUsecase {
	return &fakeUserAndFolloweePostsUsecase{
		err:           nil,
		timelineItems: nil,
	}
}

func (u *fakeUserAndFolloweePostsUsecase) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
	if u.err != nil {
		return nil, u.err
	}
	return u.timelineItems, nil
}

func (u *fakeUserAndFolloweePostsUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeUserAndFolloweePostsUsecase) ClearError() {
	u.err = nil
}

func (u *fakeUserAndFolloweePostsUsecase) SetTimelineItems(timelineItems []*entity.TimelineItem) {
	u.timelineItems = timelineItems
}
