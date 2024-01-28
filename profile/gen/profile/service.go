// Code generated by goa v3.14.0, DO NOT EDIT.
//
// profile service
//
// Command:
// $ goa gen profile/design

package profile

import (
	"context"
)

// The profile service performs operations on users' profile.
type Service interface {
	// FindByID implements FindByID.
	FindByID(context.Context, *FindByIDPayload) (res *User, err error)
}

// ServiceName is the name of the service as defined in the design. This is the
// same value that is set in the endpoint request contexts under the ServiceKey
// key.
const ServiceName = "profile"

// MethodNames lists the service method names as defined in the design. These
// are the same values that are set in the endpoint request contexts under the
// MethodKey key.
var MethodNames = [1]string{"FindByID"}

// FindByIDPayload is the payload type of the profile service FindByID method.
type FindByIDPayload struct {
	ID int
}

// User is the result type of the profile service FindByID method.
type User struct {
	Username string
	Bio      string
}
