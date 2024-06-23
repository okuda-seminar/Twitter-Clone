package repository

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type UsersRepo interface {
	// CreateUser creates a new user with the specified username.
	// The 'Bio' and 'IsPrivate' fields are set to an empty string and false.
	// If a user with the specified username already exists, the creation fails.
	CreateUser(ctx context.Context, username string, display_name string, is_private bool) (*User, error)

	// DeleteUser deletes a user with the specified user ID.
	// If a target user does not exist, it returns an error.
	DeleteUser(ctx context.Context, id uuid.UUID) error

	// FindUserByID retrieves a user by user ID from the database.
	// If a target user does not exist, it returns an error.
	FindUserByID(ctx context.Context, id uuid.UUID) (*User, error)

	// UpdateProfiles updates the fields of a user with the specified ID.
	// If a target user does not exist, it returns an error.
	UpdateProfile(ctx context.Context, id uuid.UUID, fields map[string]any) error

	// GetFollowers retrieves all the followers of a user with the specified ID.
	GetFollowers(ctx context.Context, id uuid.UUID) ([]*User, error)

	// GetFollowings retrieves all the followings of a user with the specified ID.
	GetFollowings(ctx context.Context, id uuid.UUID) ([]*User, error)
}

// User represents an entry of `users` table.
// It contains properties such as Username and DisplayName,
// which are associated with a user's identity
// Username is a unique identifier for a user's account and is preceded by the "@" symbol.
// It's used in the URL of the user's profile
// and is how other users mention or reference them in tweets.
//
// Display name is the name that appears on a user's profile and alongside their tweets.
// It doesn't need to be unique and can be changed by the user.
//
// For more information on terminology, refer to: https://help.twitter.com/en/resources/glossary
//
// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/101
// - Consider how to suggest username and check if one selected by a user is unique
type User struct {
	ID          uuid.UUID
	Username    string
	DisplayName string
	Bio         string
	CreatedAt   time.Time
	UpdatedAt   time.Time
	IsPrivate   bool
}
