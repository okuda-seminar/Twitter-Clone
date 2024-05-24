// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets client
//
// Command:
// $ goa gen tweets/design

package tweets

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// Client is the "tweets" service client.
type Client struct {
	CreateTweetEndpoint     goa.Endpoint
	DeleteTweetEndpoint     goa.Endpoint
	LikeTweetEndpoint       goa.Endpoint
	DeleteTweetLikeEndpoint goa.Endpoint
}

// NewClient initializes a "tweets" service client given the endpoints.
func NewClient(createTweet, deleteTweet, likeTweet, deleteTweetLike goa.Endpoint) *Client {
	return &Client{
		CreateTweetEndpoint:     createTweet,
		DeleteTweetEndpoint:     deleteTweet,
		LikeTweetEndpoint:       likeTweet,
		DeleteTweetLikeEndpoint: deleteTweetLike,
	}
}

// CreateTweet calls the "CreateTweet" endpoint of the "tweets" service.
// CreateTweet may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) CreateTweet(ctx context.Context, p *CreateTweetPayload) (res *Tweet, err error) {
	var ires any
	ires, err = c.CreateTweetEndpoint(ctx, p)
	if err != nil {
		return
	}
	return ires.(*Tweet), nil
}

// DeleteTweet calls the "DeleteTweet" endpoint of the "tweets" service.
// DeleteTweet may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) DeleteTweet(ctx context.Context, p *DeleteTweetPayload) (err error) {
	_, err = c.DeleteTweetEndpoint(ctx, p)
	return
}

// LikeTweet calls the "LikeTweet" endpoint of the "tweets" service.
// LikeTweet may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) LikeTweet(ctx context.Context, p *LikeTweetPayload) (err error) {
	_, err = c.LikeTweetEndpoint(ctx, p)
	return
}

// DeleteTweetLike calls the "DeleteTweetLike" endpoint of the "tweets" service.
// DeleteTweetLike may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) DeleteTweetLike(ctx context.Context, p *DeleteTweetLikePayload) (err error) {
	_, err = c.DeleteTweetLikeEndpoint(ctx, p)
	return
}
