// Code generated by goa v3.14.0, DO NOT EDIT.
//
// profile service
//
// Command:
// $ goa gen profile/design

package profile

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// The profile service performs operations on users' profile.
type Service interface {
	// CreateUser implements CreateUser.
	CreateUser(context.Context, *CreateUserPayload) (res *User, err error)
	// DeleteUser implements DeleteUser.
	DeleteUser(context.Context, *DeleteUserPayload) (err error)
	// FindByID implements FindByID.
	FindByID(context.Context, *FindByIDPayload) (res *User, err error)
	// UpdateUsername implements UpdateUsername.
	UpdateUsername(context.Context, *UpdateUsernamePayload) (err error)
	// UpdateBio implements UpdateBio.
	UpdateBio(context.Context, *UpdateBioPayload) (err error)
}

// ServiceName is the name of the service as defined in the design. This is the
// same value that is set in the endpoint request contexts under the ServiceKey
// key.
const ServiceName = "profile"

// MethodNames lists the service method names as defined in the design. These
// are the same values that are set in the endpoint request contexts under the
// MethodKey key.
var MethodNames = [5]string{"CreateUser", "DeleteUser", "FindByID", "UpdateUsername", "UpdateBio"}

// CreateUserPayload is the payload type of the profile service CreateUser
// method.
type CreateUserPayload struct {
	Username string
}

// DeleteUserPayload is the payload type of the profile service DeleteUser
// method.
type DeleteUserPayload struct {
	ID int
}

// FindByIDPayload is the payload type of the profile service FindByID method.
type FindByIDPayload struct {
	ID int
}

// UpdateBioPayload is the payload type of the profile service UpdateBio method.
type UpdateBioPayload struct {
	ID  int
	Bio string
}

// UpdateUsernamePayload is the payload type of the profile service
// UpdateUsername method.
type UpdateUsernamePayload struct {
	ID       int
	Username string
}

// User is the result type of the profile service CreateUser method.
type User struct {
	Username string
	Bio      string
}

// MakeNotFound builds a goa.ServiceError from an error.
func MakeNotFound(err error) *goa.ServiceError {
	return goa.NewServiceError(err, "NotFound", false, false, false)
}

// MakeBadRequest builds a goa.ServiceError from an error.
func MakeBadRequest(err error) *goa.ServiceError {
	return goa.NewServiceError(err, "BadRequest", false, false, false)
}
