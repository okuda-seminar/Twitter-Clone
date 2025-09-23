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
	// Real-time notification disabled - polling-based approach (fake implementation)
	return nil
}
