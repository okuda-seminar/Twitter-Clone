package api

import "x-clone-backend/internal/domain/entity"

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/720
// - [Go] Fix notification usecase to handle uuid
type UpdateNotificationUsecase interface {
	SendNotification(userID, eventType string, timelineItem *entity.TimelineItem) error
	SetChannel(userID string) (chan entity.TimelineEvent, error)
	DeleteChannel(userID string) error
}
