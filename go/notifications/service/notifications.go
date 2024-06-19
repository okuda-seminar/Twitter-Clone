package service

import (
	"context"
	"log"
	notifications "notifications/gen/notifications"
)

// notificationsSvc implements notifications/gen/notifications.Service.
type notificationsSvc struct {
	logger *log.Logger
}

// NewNotificationsSvc returns the notifications service implementation.
func NewNotificationsSvc(logger *log.Logger) notifications.Service {
	return &notificationsSvc{logger}
}

func (s *notificationsSvc) CreateTweetNotification(ctx context.Context, p *notifications.CreateTweetNotificationPayload) (err error) {
	s.logger.Print("notifications.CreateTweetNotification")
	return
}
