// Code generated by goa v3.14.0, DO NOT EDIT.
//
// users HTTP client types
//
// Command:
// $ goa gen users/design

package client

import (
	users "users/gen/users"

	goa "goa.design/goa/v3/pkg"
)

// CreateUserRequestBody is the type of the "users" service "CreateUser"
// endpoint HTTP request body.
type CreateUserRequestBody struct {
	Username    string `form:"username" json:"username" xml:"username"`
	DisplayName string `form:"display_name" json:"display_name" xml:"display_name"`
}

// DeleteUserRequestBody is the type of the "users" service "DeleteUser"
// endpoint HTTP request body.
type DeleteUserRequestBody struct {
	ID string `form:"id" json:"id" xml:"id"`
}

// UpdateUsernameRequestBody is the type of the "users" service
// "UpdateUsername" endpoint HTTP request body.
type UpdateUsernameRequestBody struct {
	Username string `form:"username" json:"username" xml:"username"`
}

// UpdateBioRequestBody is the type of the "users" service "UpdateBio" endpoint
// HTTP request body.
type UpdateBioRequestBody struct {
	Bio string `form:"bio" json:"bio" xml:"bio"`
}

// FollowRequestBody is the type of the "users" service "Follow" endpoint HTTP
// request body.
type FollowRequestBody struct {
	FollowerID string `form:"follower_id" json:"follower_id" xml:"follower_id"`
	FolloweeID string `form:"followee_id" json:"followee_id" xml:"followee_id"`
}

// UnfollowRequestBody is the type of the "users" service "Unfollow" endpoint
// HTTP request body.
type UnfollowRequestBody struct {
	FollowerID string `form:"follower_id" json:"follower_id" xml:"follower_id"`
	FolloweeID string `form:"followee_id" json:"followee_id" xml:"followee_id"`
}

// CreateUserResponseBody is the type of the "users" service "CreateUser"
// endpoint HTTP response body.
type CreateUserResponseBody struct {
	ID          *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	Username    *string `form:"username,omitempty" json:"username,omitempty" xml:"username,omitempty"`
	DisplayName *string `form:"display_name,omitempty" json:"display_name,omitempty" xml:"display_name,omitempty"`
	Bio         *string `form:"bio,omitempty" json:"bio,omitempty" xml:"bio,omitempty"`
	CreatedAt   *string `form:"created_at,omitempty" json:"created_at,omitempty" xml:"created_at,omitempty"`
	UpdatedAt   *string `form:"updated_at,omitempty" json:"updated_at,omitempty" xml:"updated_at,omitempty"`
}

// FindUserByIDResponseBody is the type of the "users" service "FindUserByID"
// endpoint HTTP response body.
type FindUserByIDResponseBody struct {
	ID          *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	Username    *string `form:"username,omitempty" json:"username,omitempty" xml:"username,omitempty"`
	DisplayName *string `form:"display_name,omitempty" json:"display_name,omitempty" xml:"display_name,omitempty"`
	Bio         *string `form:"bio,omitempty" json:"bio,omitempty" xml:"bio,omitempty"`
	CreatedAt   *string `form:"created_at,omitempty" json:"created_at,omitempty" xml:"created_at,omitempty"`
	UpdatedAt   *string `form:"updated_at,omitempty" json:"updated_at,omitempty" xml:"updated_at,omitempty"`
}

// GetFollowersResponseBody is the type of the "users" service "GetFollowers"
// endpoint HTTP response body.
type GetFollowersResponseBody []*UserResponse

// GetFollowingsResponseBody is the type of the "users" service "GetFollowings"
// endpoint HTTP response body.
type GetFollowingsResponseBody []*UserResponse

// CreateUserBadRequestResponseBody is the type of the "users" service
// "CreateUser" endpoint HTTP response body for the "BadRequest" error.
type CreateUserBadRequestResponseBody struct {
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

// DeleteUserNotFoundResponseBody is the type of the "users" service
// "DeleteUser" endpoint HTTP response body for the "NotFound" error.
type DeleteUserNotFoundResponseBody struct {
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

// DeleteUserBadRequestResponseBody is the type of the "users" service
// "DeleteUser" endpoint HTTP response body for the "BadRequest" error.
type DeleteUserBadRequestResponseBody struct {
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

// FindUserByIDNotFoundResponseBody is the type of the "users" service
// "FindUserByID" endpoint HTTP response body for the "NotFound" error.
type FindUserByIDNotFoundResponseBody struct {
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

// UpdateUsernameNotFoundResponseBody is the type of the "users" service
// "UpdateUsername" endpoint HTTP response body for the "NotFound" error.
type UpdateUsernameNotFoundResponseBody struct {
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

// UpdateUsernameBadRequestResponseBody is the type of the "users" service
// "UpdateUsername" endpoint HTTP response body for the "BadRequest" error.
type UpdateUsernameBadRequestResponseBody struct {
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

// UpdateBioNotFoundResponseBody is the type of the "users" service "UpdateBio"
// endpoint HTTP response body for the "NotFound" error.
type UpdateBioNotFoundResponseBody struct {
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

// UpdateBioBadRequestResponseBody is the type of the "users" service
// "UpdateBio" endpoint HTTP response body for the "BadRequest" error.
type UpdateBioBadRequestResponseBody struct {
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

// FollowBadRequestResponseBody is the type of the "users" service "Follow"
// endpoint HTTP response body for the "BadRequest" error.
type FollowBadRequestResponseBody struct {
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

// UnfollowBadRequestResponseBody is the type of the "users" service "Unfollow"
// endpoint HTTP response body for the "BadRequest" error.
type UnfollowBadRequestResponseBody struct {
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

// GetFollowersBadRequestResponseBody is the type of the "users" service
// "GetFollowers" endpoint HTTP response body for the "BadRequest" error.
type GetFollowersBadRequestResponseBody struct {
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

// GetFollowingsBadRequestResponseBody is the type of the "users" service
// "GetFollowings" endpoint HTTP response body for the "BadRequest" error.
type GetFollowingsBadRequestResponseBody struct {
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

// UserResponse is used to define fields on response body types.
type UserResponse struct {
	ID          *string `form:"id,omitempty" json:"id,omitempty" xml:"id,omitempty"`
	Username    *string `form:"username,omitempty" json:"username,omitempty" xml:"username,omitempty"`
	DisplayName *string `form:"display_name,omitempty" json:"display_name,omitempty" xml:"display_name,omitempty"`
	Bio         *string `form:"bio,omitempty" json:"bio,omitempty" xml:"bio,omitempty"`
	CreatedAt   *string `form:"created_at,omitempty" json:"created_at,omitempty" xml:"created_at,omitempty"`
	UpdatedAt   *string `form:"updated_at,omitempty" json:"updated_at,omitempty" xml:"updated_at,omitempty"`
}

// NewCreateUserRequestBody builds the HTTP request body from the payload of
// the "CreateUser" endpoint of the "users" service.
func NewCreateUserRequestBody(p *users.CreateUserPayload) *CreateUserRequestBody {
	body := &CreateUserRequestBody{
		Username:    p.Username,
		DisplayName: p.DisplayName,
	}
	return body
}

// NewDeleteUserRequestBody builds the HTTP request body from the payload of
// the "DeleteUser" endpoint of the "users" service.
func NewDeleteUserRequestBody(p *users.DeleteUserPayload) *DeleteUserRequestBody {
	body := &DeleteUserRequestBody{
		ID: p.ID,
	}
	return body
}

// NewUpdateUsernameRequestBody builds the HTTP request body from the payload
// of the "UpdateUsername" endpoint of the "users" service.
func NewUpdateUsernameRequestBody(p *users.UpdateUsernamePayload) *UpdateUsernameRequestBody {
	body := &UpdateUsernameRequestBody{
		Username: p.Username,
	}
	return body
}

// NewUpdateBioRequestBody builds the HTTP request body from the payload of the
// "UpdateBio" endpoint of the "users" service.
func NewUpdateBioRequestBody(p *users.UpdateBioPayload) *UpdateBioRequestBody {
	body := &UpdateBioRequestBody{
		Bio: p.Bio,
	}
	return body
}

// NewFollowRequestBody builds the HTTP request body from the payload of the
// "Follow" endpoint of the "users" service.
func NewFollowRequestBody(p *users.FollowPayload) *FollowRequestBody {
	body := &FollowRequestBody{
		FollowerID: p.FollowerID,
		FolloweeID: p.FolloweeID,
	}
	return body
}

// NewUnfollowRequestBody builds the HTTP request body from the payload of the
// "Unfollow" endpoint of the "users" service.
func NewUnfollowRequestBody(p *users.UnfollowPayload) *UnfollowRequestBody {
	body := &UnfollowRequestBody{
		FollowerID: p.FollowerID,
		FolloweeID: p.FolloweeID,
	}
	return body
}

// NewCreateUserUserOK builds a "users" service "CreateUser" endpoint result
// from a HTTP "OK" response.
func NewCreateUserUserOK(body *CreateUserResponseBody) *users.User {
	v := &users.User{
		ID:          *body.ID,
		Username:    *body.Username,
		DisplayName: *body.DisplayName,
		Bio:         *body.Bio,
		CreatedAt:   *body.CreatedAt,
		UpdatedAt:   *body.UpdatedAt,
	}

	return v
}

// NewCreateUserBadRequest builds a users service CreateUser endpoint
// BadRequest error.
func NewCreateUserBadRequest(body *CreateUserBadRequestResponseBody) *goa.ServiceError {
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

// NewDeleteUserNotFound builds a users service DeleteUser endpoint NotFound
// error.
func NewDeleteUserNotFound(body *DeleteUserNotFoundResponseBody) *goa.ServiceError {
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

// NewDeleteUserBadRequest builds a users service DeleteUser endpoint
// BadRequest error.
func NewDeleteUserBadRequest(body *DeleteUserBadRequestResponseBody) *goa.ServiceError {
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

// NewFindUserByIDUserOK builds a "users" service "FindUserByID" endpoint
// result from a HTTP "OK" response.
func NewFindUserByIDUserOK(body *FindUserByIDResponseBody) *users.User {
	v := &users.User{
		ID:          *body.ID,
		Username:    *body.Username,
		DisplayName: *body.DisplayName,
		Bio:         *body.Bio,
		CreatedAt:   *body.CreatedAt,
		UpdatedAt:   *body.UpdatedAt,
	}

	return v
}

// NewFindUserByIDNotFound builds a users service FindUserByID endpoint
// NotFound error.
func NewFindUserByIDNotFound(body *FindUserByIDNotFoundResponseBody) *goa.ServiceError {
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

// NewUpdateUsernameNotFound builds a users service UpdateUsername endpoint
// NotFound error.
func NewUpdateUsernameNotFound(body *UpdateUsernameNotFoundResponseBody) *goa.ServiceError {
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

// NewUpdateUsernameBadRequest builds a users service UpdateUsername endpoint
// BadRequest error.
func NewUpdateUsernameBadRequest(body *UpdateUsernameBadRequestResponseBody) *goa.ServiceError {
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

// NewUpdateBioNotFound builds a users service UpdateBio endpoint NotFound
// error.
func NewUpdateBioNotFound(body *UpdateBioNotFoundResponseBody) *goa.ServiceError {
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

// NewUpdateBioBadRequest builds a users service UpdateBio endpoint BadRequest
// error.
func NewUpdateBioBadRequest(body *UpdateBioBadRequestResponseBody) *goa.ServiceError {
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

// NewFollowBadRequest builds a users service Follow endpoint BadRequest error.
func NewFollowBadRequest(body *FollowBadRequestResponseBody) *goa.ServiceError {
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

// NewUnfollowBadRequest builds a users service Unfollow endpoint BadRequest
// error.
func NewUnfollowBadRequest(body *UnfollowBadRequestResponseBody) *goa.ServiceError {
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

// NewGetFollowersUserOK builds a "users" service "GetFollowers" endpoint
// result from a HTTP "OK" response.
func NewGetFollowersUserOK(body []*UserResponse) []*users.User {
	v := make([]*users.User, len(body))
	for i, val := range body {
		v[i] = unmarshalUserResponseToUsersUser(val)
	}

	return v
}

// NewGetFollowersBadRequest builds a users service GetFollowers endpoint
// BadRequest error.
func NewGetFollowersBadRequest(body *GetFollowersBadRequestResponseBody) *goa.ServiceError {
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

// NewGetFollowingsUserOK builds a "users" service "GetFollowings" endpoint
// result from a HTTP "OK" response.
func NewGetFollowingsUserOK(body []*UserResponse) []*users.User {
	v := make([]*users.User, len(body))
	for i, val := range body {
		v[i] = unmarshalUserResponseToUsersUser(val)
	}

	return v
}

// NewGetFollowingsBadRequest builds a users service GetFollowings endpoint
// BadRequest error.
func NewGetFollowingsBadRequest(body *GetFollowingsBadRequestResponseBody) *goa.ServiceError {
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

// ValidateCreateUserResponseBody runs the validations defined on
// CreateUserResponseBody
func ValidateCreateUserResponseBody(body *CreateUserResponseBody) (err error) {
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.Username == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("username", "body"))
	}
	if body.DisplayName == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("display_name", "body"))
	}
	if body.Bio == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("bio", "body"))
	}
	if body.CreatedAt == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("created_at", "body"))
	}
	if body.UpdatedAt == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("updated_at", "body"))
	}
	if body.ID != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.id", *body.ID, goa.FormatUUID))
	}
	if body.CreatedAt != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.created_at", *body.CreatedAt, goa.FormatDateTime))
	}
	if body.UpdatedAt != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.updated_at", *body.UpdatedAt, goa.FormatDateTime))
	}
	return
}

// ValidateFindUserByIDResponseBody runs the validations defined on
// FindUserByIDResponseBody
func ValidateFindUserByIDResponseBody(body *FindUserByIDResponseBody) (err error) {
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.Username == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("username", "body"))
	}
	if body.DisplayName == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("display_name", "body"))
	}
	if body.Bio == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("bio", "body"))
	}
	if body.CreatedAt == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("created_at", "body"))
	}
	if body.UpdatedAt == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("updated_at", "body"))
	}
	if body.ID != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.id", *body.ID, goa.FormatUUID))
	}
	if body.CreatedAt != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.created_at", *body.CreatedAt, goa.FormatDateTime))
	}
	if body.UpdatedAt != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.updated_at", *body.UpdatedAt, goa.FormatDateTime))
	}
	return
}

// ValidateCreateUserBadRequestResponseBody runs the validations defined on
// CreateUser_BadRequest_Response_Body
func ValidateCreateUserBadRequestResponseBody(body *CreateUserBadRequestResponseBody) (err error) {
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

// ValidateDeleteUserNotFoundResponseBody runs the validations defined on
// DeleteUser_NotFound_Response_Body
func ValidateDeleteUserNotFoundResponseBody(body *DeleteUserNotFoundResponseBody) (err error) {
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

// ValidateDeleteUserBadRequestResponseBody runs the validations defined on
// DeleteUser_BadRequest_Response_Body
func ValidateDeleteUserBadRequestResponseBody(body *DeleteUserBadRequestResponseBody) (err error) {
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

// ValidateFindUserByIDNotFoundResponseBody runs the validations defined on
// FindUserByID_NotFound_Response_Body
func ValidateFindUserByIDNotFoundResponseBody(body *FindUserByIDNotFoundResponseBody) (err error) {
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

// ValidateUpdateUsernameNotFoundResponseBody runs the validations defined on
// UpdateUsername_NotFound_Response_Body
func ValidateUpdateUsernameNotFoundResponseBody(body *UpdateUsernameNotFoundResponseBody) (err error) {
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

// ValidateUpdateUsernameBadRequestResponseBody runs the validations defined on
// UpdateUsername_BadRequest_Response_Body
func ValidateUpdateUsernameBadRequestResponseBody(body *UpdateUsernameBadRequestResponseBody) (err error) {
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

// ValidateUpdateBioNotFoundResponseBody runs the validations defined on
// UpdateBio_NotFound_Response_Body
func ValidateUpdateBioNotFoundResponseBody(body *UpdateBioNotFoundResponseBody) (err error) {
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

// ValidateUpdateBioBadRequestResponseBody runs the validations defined on
// UpdateBio_BadRequest_Response_Body
func ValidateUpdateBioBadRequestResponseBody(body *UpdateBioBadRequestResponseBody) (err error) {
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

// ValidateFollowBadRequestResponseBody runs the validations defined on
// Follow_BadRequest_Response_Body
func ValidateFollowBadRequestResponseBody(body *FollowBadRequestResponseBody) (err error) {
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

// ValidateUnfollowBadRequestResponseBody runs the validations defined on
// Unfollow_BadRequest_Response_Body
func ValidateUnfollowBadRequestResponseBody(body *UnfollowBadRequestResponseBody) (err error) {
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

// ValidateGetFollowersBadRequestResponseBody runs the validations defined on
// GetFollowers_BadRequest_Response_Body
func ValidateGetFollowersBadRequestResponseBody(body *GetFollowersBadRequestResponseBody) (err error) {
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

// ValidateGetFollowingsBadRequestResponseBody runs the validations defined on
// GetFollowings_BadRequest_Response_Body
func ValidateGetFollowingsBadRequestResponseBody(body *GetFollowingsBadRequestResponseBody) (err error) {
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

// ValidateUserResponse runs the validations defined on UserResponse
func ValidateUserResponse(body *UserResponse) (err error) {
	if body.ID == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("id", "body"))
	}
	if body.Username == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("username", "body"))
	}
	if body.DisplayName == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("display_name", "body"))
	}
	if body.Bio == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("bio", "body"))
	}
	if body.CreatedAt == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("created_at", "body"))
	}
	if body.UpdatedAt == nil {
		err = goa.MergeErrors(err, goa.MissingFieldError("updated_at", "body"))
	}
	if body.ID != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.id", *body.ID, goa.FormatUUID))
	}
	if body.CreatedAt != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.created_at", *body.CreatedAt, goa.FormatDateTime))
	}
	if body.UpdatedAt != nil {
		err = goa.MergeErrors(err, goa.ValidateFormat("body.updated_at", *body.UpdatedAt, goa.FormatDateTime))
	}
	return
}
