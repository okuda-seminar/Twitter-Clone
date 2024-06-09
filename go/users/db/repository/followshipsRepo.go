package repository

import (
	"context"

	"github.com/google/uuid"
)

type FollowshipsRepo interface {
	CreateFollowship(ctx context.Context, follower_id, followee_id uuid.UUID) error
	DeleteFollowship(ctx context.Context, follower_id, followee_id uuid.UUID) error
}

type Followship struct {
	ID         int
	FollowerID int
	FolloweeID int
}
