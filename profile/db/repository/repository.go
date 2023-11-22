package repository

import (
	"context"
	"database/sql"
	"time"
)

type Repository interface {
	FindByID(ctx context.Context, id int) (*User, error)
}

// repository implements Repository.
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
