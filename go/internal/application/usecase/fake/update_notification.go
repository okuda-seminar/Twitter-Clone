package fake

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeUpdateNotificationUsecase struct {
	err error
}

func NewFakeUpdateNotificationUsecase() usecase.UpdateNotificationUsecase {
	return &fakeUpdateNotificationUsecase{
		err: nil,
	}
}

func (u *fakeUpdateNotificationUsecase) SendNotification(userID, eventType string, timelineItem *entity.TimelineItem) error {
	if u.err != nil {
		return u.err
	}
	return nil
}

func (u *fakeUpdateNotificationUsecase) SetChannel(userID string) (chan entity.TimelineEvent, error) {
	return nil, nil
}

func (u *fakeUpdateNotificationUsecase) DeleteChannel(userID string) error {
	return nil
}

func (u *fakeUpdateNotificationUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeUpdateNotificationUsecase) ClearError() {
	u.err = nil
}
