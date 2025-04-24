package usecase

import "x-clone-backend/internal/domain/entity"

type UpdateNotificationUsecase interface {
	SendNotification(userID, eventType string, timelineItem *entity.TimelineItem) error
	SetChannel(userID string) (chan entity.TimelineEvent, error)
	DeleteChannel(userID string) error
}
