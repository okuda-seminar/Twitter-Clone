// Code generated by goa v3.15.2, DO NOT EDIT.
//
// notifications HTTP client types
//
// Command:
// $ goa gen notifications/design

package client

import (
	notifications "notifications/gen/notifications"

	goa "goa.design/goa/v3/pkg"
)

// CreateTweetNotificationRequestBody is the type of the "notifications"
// service "CreateTweetNotification" endpoint HTTP request body.
type CreateTweetNotificationRequestBody struct {
	TweetID string `form:"tweet_id" json:"tweet_id" xml:"tweet_id"`
	Text    string `form:"text" json:"text" xml:"text"`
}

// CreateTweetNotificationBadRequestResponseBody is the type of the
// "notifications" service "CreateTweetNotification" endpoint HTTP response
// body for the "BadRequest" error.
type CreateTweetNotificationBadRequestResponseBody struct {
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

// NewCreateTweetNotificationRequestBody builds the HTTP request body from the
// payload of the "CreateTweetNotification" endpoint of the "notifications"
// service.
func NewCreateTweetNotificationRequestBody(p *notifications.CreateTweetNotificationPayload) *CreateTweetNotificationRequestBody {
	body := &CreateTweetNotificationRequestBody{
		TweetID: p.TweetID,
		Text:    p.Text,
	}
	return body
}

// NewCreateTweetNotificationBadRequest builds a notifications service
// CreateTweetNotification endpoint BadRequest error.
func NewCreateTweetNotificationBadRequest(body *CreateTweetNotificationBadRequestResponseBody) *goa.ServiceError {
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

// ValidateCreateTweetNotificationBadRequestResponseBody runs the validations
// defined on CreateTweetNotification_BadRequest_Response_Body
func ValidateCreateTweetNotificationBadRequestResponseBody(body *CreateTweetNotificationBadRequestResponseBody) (err error) {
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