package repository

import (
	"context"
	"time"
)

type UsersRepo interface {
	CreateUser(ctx context.Context, username string) (*User, error)
	DeleteUser(ctx context.Context, user_id int) error
	FindUserByID(ctx context.Context, user_id int) (*User, error)
	UpdateUsername(ctx context.Context, user_id int, username string) error
	UpdateBio(ctx context.Context, user_id int, bio string) error
}

// User represents an entry of `users` table.
type User struct {
	UserID    int
	Username  string
	Bio       string
	CreatedAt time.Time
	UpdatedAt time.Time
}
