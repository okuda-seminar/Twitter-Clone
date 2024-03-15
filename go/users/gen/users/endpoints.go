// Code generated by goa v3.14.0, DO NOT EDIT.
//
// users endpoints
//
// Command:
// $ goa gen users/design

package users

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// Endpoints wraps the "users" service endpoints.
type Endpoints struct {
	CreateUser     goa.Endpoint
	DeleteUser     goa.Endpoint
	FindUserByID   goa.Endpoint
	UpdateUsername goa.Endpoint
	UpdateBio      goa.Endpoint
}

// NewEndpoints wraps the methods of the "users" service with endpoints.
func NewEndpoints(s Service) *Endpoints {
	return &Endpoints{
		CreateUser:     NewCreateUserEndpoint(s),
		DeleteUser:     NewDeleteUserEndpoint(s),
		FindUserByID:   NewFindUserByIDEndpoint(s),
		UpdateUsername: NewUpdateUsernameEndpoint(s),
		UpdateBio:      NewUpdateBioEndpoint(s),
	}
}

// Use applies the given middleware to all the "users" service endpoints.
func (e *Endpoints) Use(m func(goa.Endpoint) goa.Endpoint) {
	e.CreateUser = m(e.CreateUser)
	e.DeleteUser = m(e.DeleteUser)
	e.FindUserByID = m(e.FindUserByID)
	e.UpdateUsername = m(e.UpdateUsername)
	e.UpdateBio = m(e.UpdateBio)
}

// NewCreateUserEndpoint returns an endpoint function that calls the method
// "CreateUser" of service "users".
func NewCreateUserEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*CreateUserPayload)
		return s.CreateUser(ctx, p)
	}
}

// NewDeleteUserEndpoint returns an endpoint function that calls the method
// "DeleteUser" of service "users".
func NewDeleteUserEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*DeleteUserPayload)
		return nil, s.DeleteUser(ctx, p)
	}
}

// NewFindUserByIDEndpoint returns an endpoint function that calls the method
// "FindUserByID" of service "users".
func NewFindUserByIDEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*FindUserByIDPayload)
		return s.FindUserByID(ctx, p)
	}
}

// NewUpdateUsernameEndpoint returns an endpoint function that calls the method
// "UpdateUsername" of service "users".
func NewUpdateUsernameEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*UpdateUsernamePayload)
		return nil, s.UpdateUsername(ctx, p)
	}
}

// NewUpdateBioEndpoint returns an endpoint function that calls the method
// "UpdateBio" of service "users".
func NewUpdateBioEndpoint(s Service) goa.Endpoint {
	return func(ctx context.Context, req any) (any, error) {
		p := req.(*UpdateBioPayload)
		return nil, s.UpdateBio(ctx, p)
	}
}