// Code generated by goa v3.14.0, DO NOT EDIT.
//
// HTTP request path constructors for the users service.
//
// Command:
// $ goa gen users/design

package client

import (
	"fmt"
)

// CreateUserUsersPath returns the URL path to the users service CreateUser HTTP endpoint.
func CreateUserUsersPath() string {
	return "/api/users"
}

// DeleteUserUsersPath returns the URL path to the users service DeleteUser HTTP endpoint.
func DeleteUserUsersPath() string {
	return "/api/users"
}

// FindUserByIDUsersPath returns the URL path to the users service FindUserByID HTTP endpoint.
func FindUserByIDUsersPath(id string) string {
	return fmt.Sprintf("/api/users/%v", id)
}

// UpdateUsernameUsersPath returns the URL path to the users service UpdateUsername HTTP endpoint.
func UpdateUsernameUsersPath(id string) string {
	return fmt.Sprintf("/api/users/%v/username", id)
}

// UpdateBioUsersPath returns the URL path to the users service UpdateBio HTTP endpoint.
func UpdateBioUsersPath(id string) string {
	return fmt.Sprintf("/api/users/%v/bio", id)
}

// FollowUsersPath returns the URL path to the users service Follow HTTP endpoint.
func FollowUsersPath() string {
	return "/api/users/follow"
}

// UnfollowUsersPath returns the URL path to the users service Unfollow HTTP endpoint.
func UnfollowUsersPath() string {
	return "/api/users/follow"
}

// GetFollowersUsersPath returns the URL path to the users service GetFollowers HTTP endpoint.
func GetFollowersUsersPath(id string) string {
	return fmt.Sprintf("/api/users/%v/followers", id)
}

// GetFollowingsUsersPath returns the URL path to the users service GetFollowings HTTP endpoint.
func GetFollowingsUsersPath(id string) string {
	return fmt.Sprintf("/api/users/%v/followings", id)
}

// MuteUsersPath returns the URL path to the users service Mute HTTP endpoint.
func MuteUsersPath() string {
	return "/api/users/mute"
}

// UnmuteUsersPath returns the URL path to the users service Unmute HTTP endpoint.
func UnmuteUsersPath() string {
	return "/api/users/mute"
}

// BlockUsersPath returns the URL path to the users service Block HTTP endpoint.
func BlockUsersPath() string {
	return "/api/users/block"
}

// UnblockUsersPath returns the URL path to the users service Unblock HTTP endpoint.
func UnblockUsersPath() string {
	return "/api/users/block"
}
