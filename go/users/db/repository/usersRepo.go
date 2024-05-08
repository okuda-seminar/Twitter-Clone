package repository

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type UsersRepo interface {
	CreateUser(ctx context.Context, username string, display_name string) (*User, error)
	DeleteUser(ctx context.Context, id string) error
	FindUserByID(ctx context.Context, id string) (*User, error)
	UpdateUsername(ctx context.Context, id string, username string) error
	UpdateBio(ctx context.Context, id string, bio string) error
	GetFollowers(ctx context.Context, id string) ([]*User, error)
	GetFollowings(ctx context.Context, id string) ([]*User, error)
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
}
