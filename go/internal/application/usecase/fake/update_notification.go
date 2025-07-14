package fake

import (
	"sync"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type fakeUpdateNotificationUsecase struct {
	notificationChannel map[string]chan entity.TimelineEvent
	mu                  sync.RWMutex
	err                 error
}

func NewFakeUpdateNotificationUsecase() usecase.UpdateNotificationUsecase {
	return &fakeUpdateNotificationUsecase{
		notificationChannel: make(map[string]chan entity.TimelineEvent),
		mu:                  sync.RWMutex{},
		err:                 nil,
	}
}

func (u *fakeUpdateNotificationUsecase) SendNotification(userID, eventType string, timelineItem *entity.TimelineItem) error {
	if u.err != nil {
		return u.err
	}

	var items []*entity.TimelineItem
	items = append(items, timelineItem)

	for _, userChan := range u.notificationChannel {
		u.mu.RLock()
		userChan <- entity.TimelineEvent{EventType: eventType, TimelineItems: items}
		u.mu.RUnlock()
	}
	return nil
}

func (u *fakeUpdateNotificationUsecase) SetChannel(userID string) (chan entity.TimelineEvent, error) {
	if u.err != nil {
		return nil, u.err
	}
	u.mu.Lock()
	if _, exists := u.notificationChannel[userID]; !exists {
		u.notificationChannel[userID] = make(chan entity.TimelineEvent, 1)
	}
	userChan := u.notificationChannel[userID]
	u.mu.Unlock()
	return userChan, nil
}

func (u *fakeUpdateNotificationUsecase) DeleteChannel(userID string) error {
	u.mu.Lock()
	delete(u.notificationChannel, userID)
	u.mu.Unlock()
	return nil
}

func (u *fakeUpdateNotificationUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeUpdateNotificationUsecase) ClearError() {
	u.err = nil
}
