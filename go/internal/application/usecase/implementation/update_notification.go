package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type updateNotificationUsecase struct {
	usersRepository repository.UsersRepository
}

func NewUpdateNotificationUsecase(usersRepository repository.UsersRepository) usecase.UpdateNotificationUsecase {
	return &updateNotificationUsecase{
		usersRepository: usersRepository,
	}
}

func (u *updateNotificationUsecase) SendNotification(userID, eventType string, timelineItem *entity.TimelineItem) error {
	// Real-time notification disabled - polling-based approach
	return nil
}
