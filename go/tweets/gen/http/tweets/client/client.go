// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets client HTTP transport
//
// Command:
// $ goa gen tweets/design

package client

import (
	"context"
	"net/http"

	goahttp "goa.design/goa/v3/http"
	goa "goa.design/goa/v3/pkg"
)

// Client lists the tweets service endpoint HTTP clients.
type Client struct {
	// CreateTweet Doer is the HTTP client used to make requests to the CreateTweet
	// endpoint.
	CreateTweetDoer goahttp.Doer

	// LikeTweet Doer is the HTTP client used to make requests to the LikeTweet
	// endpoint.
	LikeTweetDoer goahttp.Doer

	// RestoreResponseBody controls whether the response bodies are reset after
	// decoding so they can be read again.
	RestoreResponseBody bool

	scheme  string
	host    string
	encoder func(*http.Request) goahttp.Encoder
	decoder func(*http.Response) goahttp.Decoder
}

// NewClient instantiates HTTP clients for all the tweets service servers.
func NewClient(
	scheme string,
	host string,
	doer goahttp.Doer,
	enc func(*http.Request) goahttp.Encoder,
	dec func(*http.Response) goahttp.Decoder,
	restoreBody bool,
) *Client {
	return &Client{
		CreateTweetDoer:     doer,
		LikeTweetDoer:       doer,
		RestoreResponseBody: restoreBody,
		scheme:              scheme,
		host:                host,
		decoder:             dec,
		encoder:             enc,
	}
}

// CreateTweet returns an endpoint that makes HTTP requests to the tweets
// service CreateTweet server.
func (c *Client) CreateTweet() goa.Endpoint {
	var (
		encodeRequest  = EncodeCreateTweetRequest(c.encoder)
		decodeResponse = DecodeCreateTweetResponse(c.decoder, c.RestoreResponseBody)
	)
	return func(ctx context.Context, v any) (any, error) {
		req, err := c.BuildCreateTweetRequest(ctx, v)
		if err != nil {
			return nil, err
		}
		err = encodeRequest(req, v)
		if err != nil {
			return nil, err
		}
		resp, err := c.CreateTweetDoer.Do(req)
		if err != nil {
			return nil, goahttp.ErrRequestError("tweets", "CreateTweet", err)
		}
		return decodeResponse(resp)
	}
}

// LikeTweet returns an endpoint that makes HTTP requests to the tweets service
// LikeTweet server.
func (c *Client) LikeTweet() goa.Endpoint {
	var (
		encodeRequest  = EncodeLikeTweetRequest(c.encoder)
		decodeResponse = DecodeLikeTweetResponse(c.decoder, c.RestoreResponseBody)
	)
	return func(ctx context.Context, v any) (any, error) {
		req, err := c.BuildLikeTweetRequest(ctx, v)
		if err != nil {
			return nil, err
		}
		err = encodeRequest(req, v)
		if err != nil {
			return nil, err
		}
		resp, err := c.LikeTweetDoer.Do(req)
		if err != nil {
			return nil, goahttp.ErrRequestError("tweets", "LikeTweet", err)
		}
		return decodeResponse(resp)
	}
}
