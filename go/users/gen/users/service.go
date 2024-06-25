// Code generated by goa v3.14.0, DO NOT EDIT.
//
// users service
//
// Command:
// $ goa gen users/design

package users

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// The users service performs operations on users information.
type Service interface {
	// CreateUser implements CreateUser.
	CreateUser(context.Context, *CreateUserPayload) (res *User, err error)
	// DeleteUser implements DeleteUser.
	DeleteUser(context.Context, *DeleteUserPayload) (err error)
	// FindUserByID implements FindUserByID.
	FindUserByID(context.Context, *FindUserByIDPayload) (res *User, err error)
	// UpdateProfile implements UpdateProfile.
	UpdateProfile(context.Context, *UpdateProfilePayload) (err error)
	// Follow implements Follow.
	Follow(context.Context, *FollowPayload) (err error)
	// Unfollow implements Unfollow.
	Unfollow(context.Context, *UnfollowPayload) (err error)
	// GetFollowers implements GetFollowers.
	GetFollowers(context.Context, *GetFollowersPayload) (res []*User, err error)
	// GetFollowings implements GetFollowings.
	GetFollowings(context.Context, *GetFollowingsPayload) (res []*User, err error)
	// Mute implements Mute.
	Mute(context.Context, *MutePayload) (err error)
	// Unmute implements Unmute.
	Unmute(context.Context, *UnmutePayload) (err error)
	// Block implements Block.
	Block(context.Context, *BlockPayload) (err error)
	// Unblock implements Unblock.
	Unblock(context.Context, *UnblockPayload) (err error)
}

// ServiceName is the name of the service as defined in the design. This is the
// same value that is set in the endpoint request contexts under the ServiceKey
// key.
const ServiceName = "users"

// MethodNames lists the service method names as defined in the design. These
// are the same values that are set in the endpoint request contexts under the
// MethodKey key.
var MethodNames = [12]string{"CreateUser", "DeleteUser", "FindUserByID", "UpdateProfile", "Follow", "Unfollow", "GetFollowers", "GetFollowings", "Mute", "Unmute", "Block", "Unblock"}

// BlockPayload is the payload type of the users service Block method.
type BlockPayload struct {
	BlockedUserID  string
	BlockingUserID string
}

// CreateUserPayload is the payload type of the users service CreateUser method.
type CreateUserPayload struct {
	Username    string
	DisplayName string
}

// DeleteUserPayload is the payload type of the users service DeleteUser method.
type DeleteUserPayload struct {
	ID string
}

// FindUserByIDPayload is the payload type of the users service FindUserByID
// method.
type FindUserByIDPayload struct {
	ID string
}

// FollowPayload is the payload type of the users service Follow method.
type FollowPayload struct {
	FollowingUserID string
	FollowedUserID  string
}

// GetFollowersPayload is the payload type of the users service GetFollowers
// method.
type GetFollowersPayload struct {
	ID string
}

// GetFollowingsPayload is the payload type of the users service GetFollowings
// method.
type GetFollowingsPayload struct {
	ID string
}

// MutePayload is the payload type of the users service Mute method.
type MutePayload struct {
	MutedUserID  string
	MutingUserID string
}

// UnblockPayload is the payload type of the users service Unblock method.
type UnblockPayload struct {
	BlockedUserID  string
	BlockingUserID string
}

// UnfollowPayload is the payload type of the users service Unfollow method.
type UnfollowPayload struct {
	FollowingUserID string
	FollowedUserID  string
}

// UnmutePayload is the payload type of the users service Unmute method.
type UnmutePayload struct {
	MutedUserID  string
	MutingUserID string
}

// UpdateProfilePayload is the payload type of the users service UpdateProfile
// method.
type UpdateProfilePayload struct {
	ID        string
	Username  *string
	Bio       *string
	IsPrivate *bool
}

// User is the result type of the users service CreateUser method.
type User struct {
	ID          string
	Username    string
	DisplayName string
	Bio         string
	CreatedAt   string
	UpdatedAt   string
	IsPrivate   bool
}

// MakeNotFound builds a goa.ServiceError from an error.
func MakeNotFound(err error) *goa.ServiceError {
	return goa.NewServiceError(err, "NotFound", false, false, false)
}

// MakeBadRequest builds a goa.ServiceError from an error.
func MakeBadRequest(err error) *goa.ServiceError {
	return goa.NewServiceError(err, "BadRequest", false, false, false)
}
