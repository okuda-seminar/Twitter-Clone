// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets HTTP client encoders and decoders
//
// Command:
// $ goa gen tweets/design

package client

import (
	"bytes"
	"context"
	"io"
	"net/http"
	"net/url"
	tweets "tweets/gen/tweets"

	goahttp "goa.design/goa/v3/http"
)

// BuildCreateTweetRequest instantiates a HTTP request object with method and
// path set to call the "tweets" service "CreateTweet" endpoint
func (c *Client) BuildCreateTweetRequest(ctx context.Context, v any) (*http.Request, error) {
	u := &url.URL{Scheme: c.scheme, Host: c.host, Path: CreateTweetTweetsPath()}
	req, err := http.NewRequest("POST", u.String(), nil)
	if err != nil {
		return nil, goahttp.ErrInvalidURL("tweets", "CreateTweet", u.String(), err)
	}
	if ctx != nil {
		req = req.WithContext(ctx)
	}

	return req, nil
}

// EncodeCreateTweetRequest returns an encoder for requests sent to the tweets
// CreateTweet server.
func EncodeCreateTweetRequest(encoder func(*http.Request) goahttp.Encoder) func(*http.Request, any) error {
	return func(req *http.Request, v any) error {
		p, ok := v.(*tweets.CreateTweetPayload)
		if !ok {
			return goahttp.ErrInvalidType("tweets", "CreateTweet", "*tweets.CreateTweetPayload", v)
		}
		body := NewCreateTweetRequestBody(p)
		if err := encoder(req).Encode(&body); err != nil {
			return goahttp.ErrEncodingError("tweets", "CreateTweet", err)
		}
		return nil
	}
}

// DecodeCreateTweetResponse returns a decoder for responses returned by the
// tweets CreateTweet endpoint. restoreBody controls whether the response body
// should be restored after having been read.
// DecodeCreateTweetResponse may return the following errors:
//   - "NotFound" (type *goa.ServiceError): http.StatusNotFound
//   - "BadRequest" (type *goa.ServiceError): http.StatusBadRequest
//   - error: internal error
func DecodeCreateTweetResponse(decoder func(*http.Response) goahttp.Decoder, restoreBody bool) func(*http.Response) (any, error) {
	return func(resp *http.Response) (any, error) {
		if restoreBody {
			b, err := io.ReadAll(resp.Body)
			if err != nil {
				return nil, err
			}
			resp.Body = io.NopCloser(bytes.NewBuffer(b))
			defer func() {
				resp.Body = io.NopCloser(bytes.NewBuffer(b))
			}()
		} else {
			defer resp.Body.Close()
		}
		switch resp.StatusCode {
		case http.StatusOK:
			var (
				body CreateTweetResponseBody
				err  error
			)
			err = decoder(resp).Decode(&body)
			if err != nil {
				return nil, goahttp.ErrDecodingError("tweets", "CreateTweet", err)
			}
			err = ValidateCreateTweetResponseBody(&body)
			if err != nil {
				return nil, goahttp.ErrValidationError("tweets", "CreateTweet", err)
			}
			res := NewCreateTweetTweetOK(&body)
			return res, nil
		case http.StatusNotFound:
			var (
				body CreateTweetNotFoundResponseBody
				err  error
			)
			err = decoder(resp).Decode(&body)
			if err != nil {
				return nil, goahttp.ErrDecodingError("tweets", "CreateTweet", err)
			}
			err = ValidateCreateTweetNotFoundResponseBody(&body)
			if err != nil {
				return nil, goahttp.ErrValidationError("tweets", "CreateTweet", err)
			}
			return nil, NewCreateTweetNotFound(&body)
		case http.StatusBadRequest:
			var (
				body CreateTweetBadRequestResponseBody
				err  error
			)
			err = decoder(resp).Decode(&body)
			if err != nil {
				return nil, goahttp.ErrDecodingError("tweets", "CreateTweet", err)
			}
			err = ValidateCreateTweetBadRequestResponseBody(&body)
			if err != nil {
				return nil, goahttp.ErrValidationError("tweets", "CreateTweet", err)
			}
			return nil, NewCreateTweetBadRequest(&body)
		default:
			body, _ := io.ReadAll(resp.Body)
			return nil, goahttp.ErrInvalidResponse("tweets", "CreateTweet", resp.StatusCode, string(body))
		}
	}
}

// BuildDeleteTweetRequest instantiates a HTTP request object with method and
// path set to call the "tweets" service "DeleteTweet" endpoint
func (c *Client) BuildDeleteTweetRequest(ctx context.Context, v any) (*http.Request, error) {
	u := &url.URL{Scheme: c.scheme, Host: c.host, Path: DeleteTweetTweetsPath()}
	req, err := http.NewRequest("DELETE", u.String(), nil)
	if err != nil {
		return nil, goahttp.ErrInvalidURL("tweets", "DeleteTweet", u.String(), err)
	}
	if ctx != nil {
		req = req.WithContext(ctx)
	}

	return req, nil
}

// EncodeDeleteTweetRequest returns an encoder for requests sent to the tweets
// DeleteTweet server.
func EncodeDeleteTweetRequest(encoder func(*http.Request) goahttp.Encoder) func(*http.Request, any) error {
	return func(req *http.Request, v any) error {
		p, ok := v.(*tweets.DeleteTweetPayload)
		if !ok {
			return goahttp.ErrInvalidType("tweets", "DeleteTweet", "*tweets.DeleteTweetPayload", v)
		}
		body := NewDeleteTweetRequestBody(p)
		if err := encoder(req).Encode(&body); err != nil {
			return goahttp.ErrEncodingError("tweets", "DeleteTweet", err)
		}
		return nil
	}
}

// DecodeDeleteTweetResponse returns a decoder for responses returned by the
// tweets DeleteTweet endpoint. restoreBody controls whether the response body
// should be restored after having been read.
// DecodeDeleteTweetResponse may return the following errors:
//   - "NotFound" (type *goa.ServiceError): http.StatusNotFound
//   - "BadRequest" (type *goa.ServiceError): http.StatusBadRequest
//   - error: internal error
func DecodeDeleteTweetResponse(decoder func(*http.Response) goahttp.Decoder, restoreBody bool) func(*http.Response) (any, error) {
	return func(resp *http.Response) (any, error) {
		if restoreBody {
			b, err := io.ReadAll(resp.Body)
			if err != nil {
				return nil, err
			}
			resp.Body = io.NopCloser(bytes.NewBuffer(b))
			defer func() {
				resp.Body = io.NopCloser(bytes.NewBuffer(b))
			}()
		} else {
			defer resp.Body.Close()
		}
		switch resp.StatusCode {
		case http.StatusOK:
			return nil, nil
		case http.StatusNotFound:
			var (
				body DeleteTweetNotFoundResponseBody
				err  error
			)
			err = decoder(resp).Decode(&body)
			if err != nil {
				return nil, goahttp.ErrDecodingError("tweets", "DeleteTweet", err)
			}
			err = ValidateDeleteTweetNotFoundResponseBody(&body)
			if err != nil {
				return nil, goahttp.ErrValidationError("tweets", "DeleteTweet", err)
			}
			return nil, NewDeleteTweetNotFound(&body)
		case http.StatusBadRequest:
			var (
				body DeleteTweetBadRequestResponseBody
				err  error
			)
			err = decoder(resp).Decode(&body)
			if err != nil {
				return nil, goahttp.ErrDecodingError("tweets", "DeleteTweet", err)
			}
			err = ValidateDeleteTweetBadRequestResponseBody(&body)
			if err != nil {
				return nil, goahttp.ErrValidationError("tweets", "DeleteTweet", err)
			}
			return nil, NewDeleteTweetBadRequest(&body)
		default:
			body, _ := io.ReadAll(resp.Body)
			return nil, goahttp.ErrInvalidResponse("tweets", "DeleteTweet", resp.StatusCode, string(body))
		}
	}
}

// BuildLikeTweetRequest instantiates a HTTP request object with method and
// path set to call the "tweets" service "LikeTweet" endpoint
func (c *Client) BuildLikeTweetRequest(ctx context.Context, v any) (*http.Request, error) {
	u := &url.URL{Scheme: c.scheme, Host: c.host, Path: LikeTweetTweetsPath()}
	req, err := http.NewRequest("POST", u.String(), nil)
	if err != nil {
		return nil, goahttp.ErrInvalidURL("tweets", "LikeTweet", u.String(), err)
	}
	if ctx != nil {
		req = req.WithContext(ctx)
	}

	return req, nil
}

// EncodeLikeTweetRequest returns an encoder for requests sent to the tweets
// LikeTweet server.
func EncodeLikeTweetRequest(encoder func(*http.Request) goahttp.Encoder) func(*http.Request, any) error {
	return func(req *http.Request, v any) error {
		p, ok := v.(*tweets.LikeTweetPayload)
		if !ok {
			return goahttp.ErrInvalidType("tweets", "LikeTweet", "*tweets.LikeTweetPayload", v)
		}
		body := NewLikeTweetRequestBody(p)
		if err := encoder(req).Encode(&body); err != nil {
			return goahttp.ErrEncodingError("tweets", "LikeTweet", err)
		}
		return nil
	}
}

// DecodeLikeTweetResponse returns a decoder for responses returned by the
// tweets LikeTweet endpoint. restoreBody controls whether the response body
// should be restored after having been read.
// DecodeLikeTweetResponse may return the following errors:
//   - "BadRequest" (type *goa.ServiceError): http.StatusBadRequest
//   - error: internal error
func DecodeLikeTweetResponse(decoder func(*http.Response) goahttp.Decoder, restoreBody bool) func(*http.Response) (any, error) {
	return func(resp *http.Response) (any, error) {
		if restoreBody {
			b, err := io.ReadAll(resp.Body)
			if err != nil {
				return nil, err
			}
			resp.Body = io.NopCloser(bytes.NewBuffer(b))
			defer func() {
				resp.Body = io.NopCloser(bytes.NewBuffer(b))
			}()
		} else {
			defer resp.Body.Close()
		}
		switch resp.StatusCode {
		case http.StatusOK:
			return nil, nil
		case http.StatusBadRequest:
			var (
				body LikeTweetBadRequestResponseBody
				err  error
			)
			err = decoder(resp).Decode(&body)
			if err != nil {
				return nil, goahttp.ErrDecodingError("tweets", "LikeTweet", err)
			}
			err = ValidateLikeTweetBadRequestResponseBody(&body)
			if err != nil {
				return nil, goahttp.ErrValidationError("tweets", "LikeTweet", err)
			}
			return nil, NewLikeTweetBadRequest(&body)
		default:
			body, _ := io.ReadAll(resp.Body)
			return nil, goahttp.ErrInvalidResponse("tweets", "LikeTweet", resp.StatusCode, string(body))
		}
	}
}

// BuildDeleteTweetLikeRequest instantiates a HTTP request object with method
// and path set to call the "tweets" service "DeleteTweetLike" endpoint
func (c *Client) BuildDeleteTweetLikeRequest(ctx context.Context, v any) (*http.Request, error) {
	u := &url.URL{Scheme: c.scheme, Host: c.host, Path: DeleteTweetLikeTweetsPath()}
	req, err := http.NewRequest("DELETE", u.String(), nil)
	if err != nil {
		return nil, goahttp.ErrInvalidURL("tweets", "DeleteTweetLike", u.String(), err)
	}
	if ctx != nil {
		req = req.WithContext(ctx)
	}

	return req, nil
}

// EncodeDeleteTweetLikeRequest returns an encoder for requests sent to the
// tweets DeleteTweetLike server.
func EncodeDeleteTweetLikeRequest(encoder func(*http.Request) goahttp.Encoder) func(*http.Request, any) error {
	return func(req *http.Request, v any) error {
		p, ok := v.(*tweets.DeleteTweetLikePayload)
		if !ok {
			return goahttp.ErrInvalidType("tweets", "DeleteTweetLike", "*tweets.DeleteTweetLikePayload", v)
		}
		body := NewDeleteTweetLikeRequestBody(p)
		if err := encoder(req).Encode(&body); err != nil {
			return goahttp.ErrEncodingError("tweets", "DeleteTweetLike", err)
		}
		return nil
	}
}

// DecodeDeleteTweetLikeResponse returns a decoder for responses returned by
// the tweets DeleteTweetLike endpoint. restoreBody controls whether the
// response body should be restored after having been read.
// DecodeDeleteTweetLikeResponse may return the following errors:
//   - "BadRequest" (type *goa.ServiceError): http.StatusBadRequest
//   - error: internal error
func DecodeDeleteTweetLikeResponse(decoder func(*http.Response) goahttp.Decoder, restoreBody bool) func(*http.Response) (any, error) {
	return func(resp *http.Response) (any, error) {
		if restoreBody {
			b, err := io.ReadAll(resp.Body)
			if err != nil {
				return nil, err
			}
			resp.Body = io.NopCloser(bytes.NewBuffer(b))
			defer func() {
				resp.Body = io.NopCloser(bytes.NewBuffer(b))
			}()
		} else {
			defer resp.Body.Close()
		}
		switch resp.StatusCode {
		case http.StatusOK:
			return nil, nil
		case http.StatusBadRequest:
			var (
				body DeleteTweetLikeBadRequestResponseBody
				err  error
			)
			err = decoder(resp).Decode(&body)
			if err != nil {
				return nil, goahttp.ErrDecodingError("tweets", "DeleteTweetLike", err)
			}
			err = ValidateDeleteTweetLikeBadRequestResponseBody(&body)
			if err != nil {
				return nil, goahttp.ErrValidationError("tweets", "DeleteTweetLike", err)
			}
			return nil, NewDeleteTweetLikeBadRequest(&body)
		default:
			body, _ := io.ReadAll(resp.Body)
			return nil, goahttp.ErrInvalidResponse("tweets", "DeleteTweetLike", resp.StatusCode, string(body))
		}
	}
}
