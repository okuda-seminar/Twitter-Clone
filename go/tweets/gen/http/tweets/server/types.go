// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets HTTP server types
//
// Command:
// $ goa gen tweets/design

package server

import (
	tweets "tweets/gen/tweets"

	goa "goa.design/goa/v3/pkg"
)

// CreateTweetRequestBody is the type of the "tweets" service "CreateTweet"
// endpoint HTTP request body.
type CreateTweetRequestBody struct {
	UserID *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
	Text   *string `form:"text,omitempty" json:"text,omitempty" xml:"text,omitempty"`
}

// DeleteTweetRequestBody is the type of the "tweets" service "DeleteTweet"
// endpoint HTTP request body.
type DeleteTweetRequestBody struct {
	ID *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
}

// LikeTweetRequestBody is the type of the "tweets" service "LikeTweet"
// endpoint HTTP request body.
type LikeTweetRequestBody struct {
	TweetID *string `form:"tweet_id,omitempty" json:"tweet_id,omitempty" xml:"tweet_id,omitempty"`
	UserID  *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
}

// DeleteTweetLikeRequestBody is the type of the "tweets" service
// "DeleteTweetLike" endpoint HTTP request body.
type DeleteTweetLikeRequestBody struct {
	TweetID *string `form:"tweet_id,omitempty" json:"tweet_id,omitempty" xml:"tweet_id,omitempty"`
	UserID  *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
}

// RetweetRequestBody is the type of the "tweets" service "Retweet" endpoint
// HTTP request body.
type RetweetRequestBody struct {
	TweetID *string `form:"tweet_id,omitempty" json:"tweet_id,omitempty" xml:"tweet_id,omitempty"`
	UserID  *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
}

// DeleteRetweetRequestBody is the type of the "tweets" service "DeleteRetweet"
// endpoint HTTP request body.
type DeleteRetweetRequestBody struct {
	TweetID *string `form:"tweet_id,omitempty" json:"tweet_id,omitempty" xml:"tweet_id,omitempty"`
	UserID  *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
}

// ReplyRequestBody is the type of the "tweets" service "Reply" endpoint HTTP
// request body.
type ReplyRequestBody struct {
	TweetID *string `form:"tweet_id,omitempty" json:"tweet_id,omitempty" xml:"tweet_id,omitempty"`
	UserID  *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
}

// DeleteReplyRequestBody is the type of the "tweets" service "DeleteReply"
// endpoint HTTP request body.
type DeleteReplyRequestBody struct {
	TweetID *string `form:"tweet_id,omitempty" json:"tweet_id,omitempty" xml:"tweet_id,omitempty"`
	UserID  *string `form:"user_id,omitempty" json:"user_id,omitempty" xml:"user_id,omitempty"`
}

// CreateTweetResponseBody is the type of the "tweets" service "CreateTweet"
// endpoint HTTP response body.
type CreateTweetResponseBody struct {
	ID        string `form:"id" json:"id" xml:"id"`
	UserID    string `form:"user_id" json:"user_id" xml:"user_id"`
	Text      string `form:"text" json:"text" xml:"text"`
	CreatedAt string `form:"created_at" json:"created_at" xml:"created_at"`
}

// CreateTweetNotFoundResponseBody is the type of the "tweets" service
// "CreateTweet" endpoint HTTP response body for the "NotFound" error.
type CreateTweetNotFoundResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// CreateTweetBadRequestResponseBody is the type of the "tweets" service
// "CreateTweet" endpoint HTTP response body for the "BadRequest" error.
type CreateTweetBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// DeleteTweetNotFoundResponseBody is the type of the "tweets" service
// "DeleteTweet" endpoint HTTP response body for the "NotFound" error.
type DeleteTweetNotFoundResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// DeleteTweetBadRequestResponseBody is the type of the "tweets" service
// "DeleteTweet" endpoint HTTP response body for the "BadRequest" error.
type DeleteTweetBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// LikeTweetBadRequestResponseBody is the type of the "tweets" service
// "LikeTweet" endpoint HTTP response body for the "BadRequest" error.
type LikeTweetBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// DeleteTweetLikeBadRequestResponseBody is the type of the "tweets" service
// "DeleteTweetLike" endpoint HTTP response body for the "BadRequest" error.
type DeleteTweetLikeBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// RetweetBadRequestResponseBody is the type of the "tweets" service "Retweet"
// endpoint HTTP response body for the "BadRequest" error.
type RetweetBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// DeleteRetweetBadRequestResponseBody is the type of the "tweets" service
// "DeleteRetweet" endpoint HTTP response body for the "BadRequest" error.
type DeleteRetweetBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// ReplyBadRequestResponseBody is the type of the "tweets" service "Reply"
// endpoint HTTP response body for the "BadRequest" error.
type ReplyBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// DeleteReplyBadRequestResponseBody is the type of the "tweets" service
// "DeleteReply" endpoint HTTP response body for the "BadRequest" error.
type DeleteReplyBadRequestResponseBody struct {
	// Name is the name of this class of errors.
	Name string `form:"name" json:"name" xml:"name"`
	// ID is a unique identifier for this particular occurrence of the problem.
	ID string `form:"id" json:"id" xml:"id"`
	// Message is a human-readable explanation specific to this occurrence of the
	// problem.
	Message string `form:"message" json:"message" xml:"message"`
	// Is the error temporary?
	Temporary bool `form:"temporary" json:"temporary" xml:"temporary"`
	// Is the error a timeout?
	Timeout bool `form:"timeout" json:"timeout" xml:"timeout"`
	// Is the error a server-side fault?
	Fault bool `form:"fault" json:"fault" xml:"fault"`
}

// NewCreateTweetResponseBody builds the HTTP response body from the result of
// the "CreateTweet" endpoint of the "tweets" service.
func NewCreateTweetResponseBody(res *tweets.Tweet) *CreateTweetResponseBody {
	body := &CreateTweetResponseBody{
		ID:        res.ID,
		UserID:    res.UserID,
		Text:      res.Text,
		CreatedAt: res.CreatedAt,
	}
	return body
}

// NewCreateTweetNotFoundResponseBody builds the HTTP response body from the
// result of the "CreateTweet" endpoint of the "tweets" service.
func NewCreateTweetNotFoundResponseBody(res *goa.ServiceError) *CreateTweetNotFoundResponseBody {
	body := &CreateTweetNotFoundResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewCreateTweetBadRequestResponseBody builds the HTTP response body from the
// result of the "CreateTweet" endpoint of the "tweets" service.
func NewCreateTweetBadRequestResponseBody(res *goa.ServiceError) *CreateTweetBadRequestResponseBody {
	body := &CreateTweetBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewDeleteTweetNotFoundResponseBody builds the HTTP response body from the
// result of the "DeleteTweet" endpoint of the "tweets" service.
func NewDeleteTweetNotFoundResponseBody(res *goa.ServiceError) *DeleteTweetNotFoundResponseBody {
	body := &DeleteTweetNotFoundResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewDeleteTweetBadRequestResponseBody builds the HTTP response body from the
// result of the "DeleteTweet" endpoint of the "tweets" service.
func NewDeleteTweetBadRequestResponseBody(res *goa.ServiceError) *DeleteTweetBadRequestResponseBody {
	body := &DeleteTweetBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewLikeTweetBadRequestResponseBody builds the HTTP response body from the
// result of the "LikeTweet" endpoint of the "tweets" service.
func NewLikeTweetBadRequestResponseBody(res *goa.ServiceError) *LikeTweetBadRequestResponseBody {
	body := &LikeTweetBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewDeleteTweetLikeBadRequestResponseBody builds the HTTP response body from
// the result of the "DeleteTweetLike" endpoint of the "tweets" service.
func NewDeleteTweetLikeBadRequestResponseBody(res *goa.ServiceError) *DeleteTweetLikeBadRequestResponseBody {
	body := &DeleteTweetLikeBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewRetweetBadRequestResponseBody builds the HTTP response body from the
// result of the "Retweet" endpoint of the "tweets" service.
func NewRetweetBadRequestResponseBody(res *goa.ServiceError) *RetweetBadRequestResponseBody {
	body := &RetweetBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewDeleteRetweetBadRequestResponseBody builds the HTTP response body from
// the result of the "DeleteRetweet" endpoint of the "tweets" service.
func NewDeleteRetweetBadRequestResponseBody(res *goa.ServiceError) *DeleteRetweetBadRequestResponseBody {
	body := &DeleteRetweetBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewReplyBadRequestResponseBody builds the HTTP response body from the result
// of the "Reply" endpoint of the "tweets" service.
func NewReplyBadRequestResponseBody(res *goa.ServiceError) *ReplyBadRequestResponseBody {
	body := &ReplyBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewDeleteReplyBadRequestResponseBody builds the HTTP response body from the
// result of the "DeleteReply" endpoint of the "tweets" service.
func NewDeleteReplyBadRequestResponseBody(res *goa.ServiceError) *DeleteReplyBadRequestResponseBody {
	body := &DeleteReplyBadRequestResponseBody{
		Name:      res.Name,
		ID:        res.ID,
		Message:   res.Message,
		Temporary: res.Temporary,
		Timeout:   res.Timeout,
		Fault:     res.Fault,
	}
	return body
}

// NewCreateTweetPayload builds a tweets service CreateTweet endpoint payload.
func NewCreateTweetPayload(body *CreateTweetRequestBody) *tweets.CreateTweetPayload {
	v := &tweets.CreateTweetPayload{
		UserID: *body.UserID,
		Text:   *body.Text,
	}

	return v
}

// NewDeleteTweetPayload builds a tweets service DeleteTweet endpoint payload.
func NewDeleteTweetPayload(body *DeleteTweetRequestBody) *tweets.DeleteTweetPayload {
	v := &tweets.DeleteTweetPayload{
		ID: *body.ID,
	}

	return v
}

// NewLikeTweetPayload builds a tweets service LikeTweet endpoint payload.
func NewLikeTweetPayload(body *LikeTweetRequestBody) *tweets.LikeTweetPayload {
	v := &tweets.LikeTweetPayload{
		TweetID: *body.TweetID,
		UserID:  *body.UserID,
	}

	return v
}

// NewDeleteTweetLikePayload builds a tweets service DeleteTweetLike endpoint
// payload.
func NewDeleteTweetLikePayload(body *DeleteTweetLikeRequestBody) *tweets.DeleteTweetLikePayload {
	v := &tweets.DeleteTweetLikePayload{
		TweetID: *body.TweetID,
		UserID:  *body.UserID,
	}

	return v
}

// NewRetweetPayload builds a tweets service Retweet endpoint payload.
func NewRetweetPayload(body *RetweetRequestBody) *tweets.RetweetPayload {
	v := &tweets.RetweetPayload{
		TweetID: *body.TweetID,
		UserID:  *body.UserID,
	}

	return v
}

// NewDeleteRetweetPayload builds a tweets service DeleteRetweet endpoint
// payload.
func NewDeleteRetweetPayload(body *DeleteRetweetRequestBody) *tweets.DeleteRetweetPayload {
	v := &tweets.DeleteRetweetPayload{
		TweetID: *body.TweetID,
		UserID:  *body.UserID,
	}

	return v
}

// NewReplyPayload builds a tweets service Reply endpoint payload.
func NewReplyPayload(body *ReplyRequestBody) *tweets.ReplyPayload {
	v := &tweets.ReplyPayload{
		TweetID: *body.TweetID,
		UserID:  *body.UserID,
	}

	return v
}

// NewDeleteReplyPayload builds a tweets service DeleteReply endpoint payload.
func NewDeleteReplyPayload(body *DeleteReplyRequestBody) *tweets.DeleteReplyPayload {
	v := &tweets.DeleteReplyPayload{
		TweetID: *body.TweetID,
		UserID:  *body.UserID,
	}

	return v
}

// ValidateCreateTweetRequestBody runs the validations defined on
// CreateTweetRequestBody
func ValidateCreateTweetRequestBody(body *CreateTweetRequestBody) (err error) {
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	if body.Text == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("text", "body"))
	}
	return
}

// ValidateDeleteTweetRequestBody runs the validations defined on
// DeleteTweetRequestBody
func ValidateDeleteTweetRequestBody(body *DeleteTweetRequestBody) (err error) {
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	return
}

// ValidateLikeTweetRequestBody runs the validations defined on
// LikeTweetRequestBody
func ValidateLikeTweetRequestBody(body *LikeTweetRequestBody) (err error) {
	if body.TweetID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("tweet_id", "body"))
	}
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	return
}

// ValidateDeleteTweetLikeRequestBody runs the validations defined on
// DeleteTweetLikeRequestBody
func ValidateDeleteTweetLikeRequestBody(body *DeleteTweetLikeRequestBody) (err error) {
	if body.TweetID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("tweet_id", "body"))
	}
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	return
}

// ValidateRetweetRequestBody runs the validations defined on RetweetRequestBody
func ValidateRetweetRequestBody(body *RetweetRequestBody) (err error) {
	if body.TweetID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("tweet_id", "body"))
	}
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	return
}

// ValidateDeleteRetweetRequestBody runs the validations defined on
// DeleteRetweetRequestBody
func ValidateDeleteRetweetRequestBody(body *DeleteRetweetRequestBody) (err error) {
	if body.TweetID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("tweet_id", "body"))
	}
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	return
}

// ValidateReplyRequestBody runs the validations defined on ReplyRequestBody
func ValidateReplyRequestBody(body *ReplyRequestBody) (err error) {
	if body.TweetID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("tweet_id", "body"))
	}
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	return
}

// ValidateDeleteReplyRequestBody runs the validations defined on
// DeleteReplyRequestBody
func ValidateDeleteReplyRequestBody(body *DeleteReplyRequestBody) (err error) {
	if body.TweetID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("tweet_id", "body"))
	}
	if body.UserID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("user_id", "body"))
	}
	return
}
