package api

import "x-clone-backend/internal/domain/entity"

type UpdateNotificationUsecase interface {
	SendNotification(userID, eventType string, timelineItem *entity.TimelineItem) error
}
