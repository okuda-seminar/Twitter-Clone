// Code generated by goa v3.14.0, DO NOT EDIT.
//
// users client
//
// Command:
// $ goa gen users/design

package users

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// Client is the "users" service client.
type Client struct {
	CreateUserEndpoint     goa.Endpoint
	DeleteUserEndpoint     goa.Endpoint
	FindUserByIDEndpoint   goa.Endpoint
	UpdateUsernameEndpoint goa.Endpoint
	UpdateBioEndpoint      goa.Endpoint
}

// NewClient initializes a "users" service client given the endpoints.
func NewClient(createUser, deleteUser, findUserByID, updateUsername, updateBio goa.Endpoint) *Client {
	return &Client{
		CreateUserEndpoint:     createUser,
		DeleteUserEndpoint:     deleteUser,
		FindUserByIDEndpoint:   findUserByID,
		UpdateUsernameEndpoint: updateUsername,
		UpdateBioEndpoint:      updateBio,
	}
}

// CreateUser calls the "CreateUser" endpoint of the "users" service.
// CreateUser may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) CreateUser(ctx context.Context, p *CreateUserPayload) (res *User, err error) {
	var ires any
	ires, err = c.CreateUserEndpoint(ctx, p)
	if err != nil {
		return
	}
	return ires.(*User), nil
}

// DeleteUser calls the "DeleteUser" endpoint of the "users" service.
// DeleteUser may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) DeleteUser(ctx context.Context, p *DeleteUserPayload) (err error) {
	_, err = c.DeleteUserEndpoint(ctx, p)
	return
}

// FindUserByID calls the "FindUserByID" endpoint of the "users" service.
// FindUserByID may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) FindUserByID(ctx context.Context, p *FindUserByIDPayload) (res *User, err error) {
	var ires any
	ires, err = c.FindUserByIDEndpoint(ctx, p)
	if err != nil {
		return
	}
	return ires.(*User), nil
}

// UpdateUsername calls the "UpdateUsername" endpoint of the "users" service.
// UpdateUsername may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) UpdateUsername(ctx context.Context, p *UpdateUsernamePayload) (err error) {
	_, err = c.UpdateUsernameEndpoint(ctx, p)
	return
}

// UpdateBio calls the "UpdateBio" endpoint of the "users" service.
// UpdateBio may return the following errors:
//   - "NotFound" (type *goa.ServiceError)
//   - "BadRequest" (type *goa.ServiceError)
//   - error: internal error
func (c *Client) UpdateBio(ctx context.Context, p *UpdateBioPayload) (err error) {
	_, err = c.UpdateBioEndpoint(ctx, p)
	return
}