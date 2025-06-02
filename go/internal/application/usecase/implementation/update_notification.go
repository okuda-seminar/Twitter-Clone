package implementation

import (
	"log"
	"sync"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type updateNotificationUsecase struct {
	usersRepository     repository.UsersRepository
	notificationChannel map[string]chan entity.TimelineEvent
	mu                  sync.Mutex
}

func NewUpdateNotificationUsecase(usersRepository repository.UsersRepository) usecase.UpdateNotificationUsecase {
	return &updateNotificationUsecase{
		usersRepository:     usersRepository,
		notificationChannel: make(map[string]chan entity.TimelineEvent),
		mu:                  sync.Mutex{},
	}
}

func (u *updateNotificationUsecase) SendNotification(userID, eventType string, timelineItem *entity.TimelineItem) error {
	var items []*entity.TimelineItem
	items = append(items, timelineItem)
	ids, err := u.usersRepository.Followees(nil, userID)
	if err != nil {
		log.Fatalln(err)
		return err
	}

	ids = append(ids, userID)
	for _, id := range ids {
		u.mu.Lock()
		if userChan, ok := u.notificationChannel[id]; ok {
			userChan <- entity.TimelineEvent{EventType: eventType, TimelineItems: items}
		}
		u.mu.Unlock()
	}

	return nil
}

func (u *updateNotificationUsecase) SetChannel(userID string) (chan entity.TimelineEvent, error) {
	u.mu.Lock()
	if _, exists := u.notificationChannel[userID]; !exists {
		u.notificationChannel[userID] = make(chan entity.TimelineEvent, 1)
	}
	userChan := u.notificationChannel[userID]
	u.mu.Unlock()
	return userChan, nil
}

func (u *updateNotificationUsecase) DeleteChannel(userID string) error {
	u.mu.Lock()
	delete(u.notificationChannel, userID)
	u.mu.Unlock()
	return nil
}

func (u *updateNotificationUsecase) SetError(err error) {}
func (u *updateNotificationUsecase) ClearError()        {}
