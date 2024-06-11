package service

import (
	"context"
	"log"
	notification "notification/gen/notification"
)

// notificationSvc implements notification/gen/notification.Service.
type notificationSvc struct {
	logger *log.Logger
}

// NewNotificationSvc returns the notification service implementation.
func NewNotificationSvc(logger *log.Logger) notification.Service {
	return &notificationSvc{logger}
}

func (s *notificationSvc) CreateTweetNotification(ctx context.Context, p *notification.CreateTweetNotificationPayload) (err error) {
	s.logger.Print("notification.CreateTweetNotification")
	return
}
