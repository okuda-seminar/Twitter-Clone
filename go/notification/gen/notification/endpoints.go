// Code generated by goa v3.15.2, DO NOT EDIT.
//
// notification endpoints
//
// Command:
// $ goa gen notification/design

package notification

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// Endpoints wraps the "notification" service endpoints.
type Endpoints struct {
	CreateTweetNotification goa.Endpoint
}

// NewEndpoints wraps the methods of the "notification" service with endpoints.
func NewEndpoints(s Service) *Endpoints {
	return &Endpoints{
		CreateTweetNotification: NewCreateTweetNotificationEndpoint(s),
	}
}

// Use applies the given middleware to all the "notification" service endpoints.
func (e *Endpoints) Use(m func(goa.Endpoint) goa.Endpoint) {
	e.CreateTweetNotification = m(e.CreateTweetNotification)
}

// NewCreateTweetNotificationEndpoint returns an endpoint function that calls
// the method "CreateTweetNotification" of service "notification".
func NewCreateTweetNotificationEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*CreateTweetNotificationPayload)
		return nil, s.CreateTweetNotification(ctx, p)
	}
}
