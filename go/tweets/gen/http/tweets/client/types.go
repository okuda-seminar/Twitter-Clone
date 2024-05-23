// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets HTTP client types
//
// Command:
// $ goa gen tweets/design

package client

import (
	tweets "tweets/gen/tweets"

	goa "goa.design/goa/v3/pkg"
)

// CreateTweetRequestBody is the type of the "tweets" service "CreateTweet"
// endpoint HTTP request body.
type CreateTweetRequestBody struct {
	UserID string `form:"user_id" json:"user_id" xml:"user_id"`
	Text   string `form:"text" json:"text" xml:"text"`
}

// LikeTweetRequestBody is the type of the "tweets" service "LikeTweet"
// endpoint HTTP request body.
type LikeTweetRequestBody struct {
	TweetID string `form:"tweet_id" json:"tweet_id" xml:"tweet_id"`
	UserID  string `form:"user_id" json:"user_id" xml:"user_id"`
}

// DeleteTweetLikeRequestBody is the type of the "tweets" service
// "DeleteTweetLike" endpoint HTTP request body.
type DeleteTweetLikeRequestBody struct {
	TweetID string `form:"tweet_id" json:"tweet_id" xml:"tweet_id"`
	UserID  string `form:"user_id" json:"user_id" xml:"user_id"`
}

// CreateTweetResponseBody is the type of the "tweets" service "CreateTweet"
// endpoint HTTP response body.
type CreateTweetResponseBody struct {
	ID        *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	UserID    *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
	Text      *string `form:"text,omitempty" json:"text,omitempty" xml:"text,omitempty"`
	CreatedAt *string `form:"created_at,omitempty" json:"created_at,omitempty" xml:"created_at,omitempty"`
}

// CreateTweetNotFoundResponseBody is the type of the "tweets" service
// "CreateTweet" endpoint HTTP response body for the "NotFound" error.
type CreateTweetNotFoundResponseBody struct {
	// Name is the name of this class of errors.
	Name *string `form:"name,omitempty" json:"name,omitempty" xml:"name,omitempty"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message *string `form:"message,omitempty" json:"message,omitempty" xml:"message,omitempty"`
	// Is the error temporary?
	Temporary *bool `form:"temporary,omitempty" json:"temporary,omitempty" xml:"temporary,omitempty"`
	// Is the error a timeout?
	Timeout *bool `form:"timeout,omitempty" json:"timeout,omitempty" xml:"timeout,omitempty"`
	// Is the error a server-side fault?
	Fault *bool `form:"fault,omitempty" json:"fault,omitempty" xml:"fault,omitempty"`
}

// CreateTweetBadRequestResponseBody is the type of the "tweets" service
// "CreateTweet" endpoint HTTP response body for the "BadRequest" error.
type CreateTweetBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name *string `form:"name,omitempty" json:"name,omitempty" xml:"name,omitempty"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message *string `form:"message,omitempty" json:"message,omitempty" xml:"message,omitempty"`
	// Is the error temporary?
	Temporary *bool `form:"temporary,omitempty" json:"temporary,omitempty" xml:"temporary,omitempty"`
	// Is the error a timeout?
	Timeout *bool `form:"timeout,omitempty" json:"timeout,omitempty" xml:"timeout,omitempty"`
	// Is the error a server-side fault?
	Fault *bool `form:"fault,omitempty" json:"fault,omitempty" xml:"fault,omitempty"`
}

// LikeTweetBadRequestResponseBody is the type of the "tweets" service
// "LikeTweet" endpoint HTTP response body for the "BadRequest" error.
type LikeTweetBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name *string `form:"name,omitempty" json:"name,omitempty" xml:"name,omitempty"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message *string `form:"message,omitempty" json:"message,omitempty" xml:"message,omitempty"`
	// Is the error temporary?
	Temporary *bool `form:"temporary,omitempty" json:"temporary,omitempty" xml:"temporary,omitempty"`
	// Is the error a timeout?
	Timeout *bool `form:"timeout,omitempty" json:"timeout,omitempty" xml:"timeout,omitempty"`
	// Is the error a server-side fault?
	Fault *bool `form:"fault,omitempty" json:"fault,omitempty" xml:"fault,omitempty"`
}

// DeleteTweetLikeBadRequestResponseBody is the type of the "tweets" service
// "DeleteTweetLike" endpoint HTTP response body for the "BadRequest" error.
type DeleteTweetLikeBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name *string `form:"name,omitempty" json:"name,omitempty" xml:"name,omitempty"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message *string `form:"message,omitempty" json:"message,omitempty" xml:"message,omitempty"`
	// Is the error temporary?
	Temporary *bool `form:"temporary,omitempty" json:"temporary,omitempty" xml:"temporary,omitempty"`
	// Is the error a timeout?
	Timeout *bool `form:"timeout,omitempty" json:"timeout,omitempty" xml:"timeout,omitempty"`
	// Is the error a server-side fault?
	Fault *bool `form:"fault,omitempty" json:"fault,omitempty" xml:"fault,omitempty"`
}

// NewCreateTweetRequestBody builds the HTTP request body from the payload of
// the "CreateTweet" endpoint of the "tweets" service.
func NewCreateTweetRequestBody(p *tweets.CreateTweetPayload) *CreateTweetRequestBody {
	body := &CreateTweetRequestBody{
		UserID: p.UserID,
		Text:   p.Text,
	}
	return body
}

// NewLikeTweetRequestBody builds the HTTP request body from the payload of the
// "LikeTweet" endpoint of the "tweets" service.
func NewLikeTweetRequestBody(p *tweets.LikeTweetPayload) *LikeTweetRequestBody {
	body := &LikeTweetRequestBody{
		TweetID: p.TweetID,
		UserID:  p.UserID,
	}
	return body
}

// NewDeleteTweetLikeRequestBody builds the HTTP request body from the payload
// of the "DeleteTweetLike" endpoint of the "tweets" service.
func NewDeleteTweetLikeRequestBody(p *tweets.DeleteTweetLikePayload) *DeleteTweetLikeRequestBody {
	body := &DeleteTweetLikeRequestBody{
		TweetID: p.TweetID,
		UserID:  p.UserID,
	}
	return body
}

// NewCreateTweetTweetOK builds a "tweets" service "CreateTweet" endpoint
// result from a HTTP "OK" response.
func NewCreateTweetTweetOK(body *CreateTweetResponseBody) *tweets.Tweet {
	v := &tweets.Tweet{
		ID:        *body.ID,
		UserID:    *body.UserID,
		Text:      *body.Text,
		CreatedAt: *body.CreatedAt,
	}

	return v
}

// NewCreateTweetNotFound builds a tweets service CreateTweet endpoint NotFound
// error.
func NewCreateTweetNotFound(body *CreateTweetNotFoundResponseBody) *goa.ServiceError {
	v := &goa.ServiceError{
		Name:      *body.Name,
		ID:        *body.ID,
		Message:   *body.Message,
		Temporary: *body.Temporary,
		Timeout:   *body.Timeout,
		Fault:     *body.Fault,
	}

	return v
}

// NewCreateTweetBadRequest builds a tweets service CreateTweet endpoint
// BadRequest error.
func NewCreateTweetBadRequest(body *CreateTweetBadRequestResponseBody) *goa.ServiceError {
	v := &goa.ServiceError{
		Name:      *body.Name,
		ID:        *body.ID,
		Message:   *body.Message,
		Temporary: *body.Temporary,
		Timeout:   *body.Timeout,
		Fault:     *body.Fault,
	}

	return v
}

// NewLikeTweetBadRequest builds a tweets service LikeTweet endpoint BadRequest
// error.
func NewLikeTweetBadRequest(body *LikeTweetBadRequestResponseBody) *goa.ServiceError {
	v := &goa.ServiceError{
		Name:      *body.Name,
		ID:        *body.ID,
		Message:   *body.Message,
		Temporary: *body.Temporary,
		Timeout:   *body.Timeout,
		Fault:     *body.Fault,
	}

	return v
}

// NewDeleteTweetLikeBadRequest builds a tweets service DeleteTweetLike
// endpoint BadRequest error.
func NewDeleteTweetLikeBadRequest(body *DeleteTweetLikeBadRequestResponseBody) *goa.ServiceError {
	v := &goa.ServiceError{
		Name:      *body.Name,
		ID:        *body.ID,
		Message:   *body.Message,
		Temporary: *body.Temporary,
		Timeout:   *body.Timeout,
		Fault:     *body.Fault,
	}

	return v
}

// ValidateCreateTweetResponseBody runs the validations defined on
// CreateTweetResponseBody
func ValidateCreateTweetResponseBody(body *CreateTweetResponseBody) (err error) {
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	if body.Text == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("text", "body"))
	}
	if body.CreatedAt == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("created_at", "body"))
	}
	if body.CreatedAt != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.created_at", *body.CreatedAt, goa.FormatDateTime))
	}
	return
}

// ValidateCreateTweetNotFoundResponseBody runs the validations defined on
// CreateTweet_NotFound_Response_Body
func ValidateCreateTweetNotFoundResponseBody(body *CreateTweetNotFoundResponseBody) (err error) {
	if body.Name == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("name", "body"))
	}
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.Message == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("message", "body"))
	}
	if body.Temporary == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("temporary", "body"))
	}
	if body.Timeout == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("timeout", "body"))
	}
	if body.Fault == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("fault", "body"))
	}
	return
}

// ValidateCreateTweetBadRequestResponseBody runs the validations defined on
// CreateTweet_BadRequest_Response_Body
func ValidateCreateTweetBadRequestResponseBody(body *CreateTweetBadRequestResponseBody) (err error) {
	if body.Name == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("name", "body"))
	}
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.Message == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("message", "body"))
	}
	if body.Temporary == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("temporary", "body"))
	}
	if body.Timeout == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("timeout", "body"))
	}
	if body.Fault == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("fault", "body"))
	}
	return
}

// ValidateLikeTweetBadRequestResponseBody runs the validations defined on
// LikeTweet_BadRequest_Response_Body
func ValidateLikeTweetBadRequestResponseBody(body *LikeTweetBadRequestResponseBody) (err error) {
	if body.Name == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("name", "body"))
	}
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.Message == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("message", "body"))
	}
	if body.Temporary == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("temporary", "body"))
	}
	if body.Timeout == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("timeout", "body"))
	}
	if body.Fault == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("fault", "body"))
	}
	return
}

// ValidateDeleteTweetLikeBadRequestResponseBody runs the validations defined
// on DeleteTweetLike_BadRequest_Response_Body
func ValidateDeleteTweetLikeBadRequestResponseBody(body *DeleteTweetLikeBadRequestResponseBody) (err error) {
	if body.Name == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("name", "body"))
	}
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.Message == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("message", "body"))
	}
	if body.Temporary == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("temporary", "body"))
	}
	if body.Timeout == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("timeout", "body"))
	}
	if body.Fault == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("fault", "body"))
	}
	return
}
