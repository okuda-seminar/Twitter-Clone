package notificationapi

import (
	"log"
	notification "notification/gen/notification"
)

// notification service example implementation.
// The example methods log the requests and return zero values.
type notificationsrvc struct {
	logger *log.Logger
}

// NewNotification returns the notification service implementation.
func NewNotification(logger *log.Logger) notification.Service {
	return &notificationsrvc{logger}
}
