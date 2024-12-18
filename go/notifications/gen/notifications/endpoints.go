// Code generated by goa v3.15.2, DO NOT EDIT.
//
// notifications endpoints
//
// Command:
// $ goa gen notifications/design

package notifications

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// Endpoints wraps the "notifications" service endpoints.
type Endpoints struct {
	CreateTweetNotification goa.Endpoint
}

// NewEndpoints wraps the methods of the "notifications" service with endpoints.
func NewEndpoints(s Service) *Endpoints {
	return &Endpoints{
		CreateTweetNotification: NewCreateTweetNotificationEndpoint(s),
	}
}

// Use applies the given middleware to all the "notifications" service
// endpoints.
func (e *Endpoints) Use(m func(goa.Endpoint) goa.Endpoint) {
	e.CreateTweetNotification = m(e.CreateTweetNotification)
}

// NewCreateTweetNotificationEndpoint returns an endpoint function that calls
// the method "CreateTweetNotification" of service "notifications".
func NewCreateTweetNotificationEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*CreateTweetNotificationPayload)
		return nil, s.CreateTweetNotification(ctx, p)
	}
}
