// Code generated by goa v3.14.0, DO NOT EDIT.
//
// HTTP request path constructors for the users service.
//
// Command:
// $ goa gen users/design

package server

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
func FindUserByIDUsersPath(id int) string {
	return fmt.Sprintf("/api/users/%v", id)
}

// UpdateUsernameUsersPath returns the URL path to the users service UpdateUsername HTTP endpoint.
func UpdateUsernameUsersPath(id int) string {
	return fmt.Sprintf("/api/users/%v/username", id)
}

// UpdateBioUsersPath returns the URL path to the users service UpdateBio HTTP endpoint.
func UpdateBioUsersPath(id int) string {
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
func GetFollowersUsersPath(id int) string {
	return fmt.Sprintf("/api/users/%v/followers", id)
}

// GetFollowingsUsersPath returns the URL path to the users service GetFollowings HTTP endpoint.
func GetFollowingsUsersPath(id int) string {
	return fmt.Sprintf("/api/users/%v/followings", id)
}
