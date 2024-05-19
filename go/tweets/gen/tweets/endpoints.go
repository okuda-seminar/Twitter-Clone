// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets endpoints
//
// Command:
// $ goa gen tweets/design

package tweets

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// Endpoints wraps the "tweets" service endpoints.
type Endpoints struct {
	CreateTweet goa.Endpoint
	LikeTweet   goa.Endpoint
}

// NewEndpoints wraps the methods of the "tweets" service with endpoints.
func NewEndpoints(s Service) *Endpoints {
	return &Endpoints{
		CreateTweet: NewCreateTweetEndpoint(s),
		LikeTweet:   NewLikeTweetEndpoint(s),
	}
}

// Use applies the given middleware to all the "tweets" service endpoints.
func (e *Endpoints) Use(m func(goa.Endpoint) goa.Endpoint) {
	e.CreateTweet = m(e.CreateTweet)
	e.LikeTweet = m(e.LikeTweet)
}

// NewCreateTweetEndpoint returns an endpoint function that calls the method
// "CreateTweet" of service "tweets".
func NewCreateTweetEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*CreateTweetPayload)
		return s.CreateTweet(ctx, p)
	}
}

// NewLikeTweetEndpoint returns an endpoint function that calls the method
// "LikeTweet" of service "tweets".
func NewLikeTweetEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*LikeTweetPayload)
		return nil, s.LikeTweet(ctx, p)
	}
}
