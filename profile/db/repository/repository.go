package repository

import (
	"context"
	"database/sql"
	"time"
)

type Repository interface {
	CreateUser(ctx context.Context, username string) (*User, error)
	DeleteUser(ctx context.Context, id int) error
	FindByID(ctx context.Context, id int) (*User, error)
	UpdateUsername(ctx context.Context, id int, username string) error
	UpdateBio(ctx context.Context, id int, bio string) error
}

// repository holds a connection to DB.
type repository struct {
	db *sql.DB
}

func NewRepository(db *sql.DB) repository {
	return repository{db}
}

type User struct {
	ID        int
	Username  string
	Bio       string
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt time.Time
}
