package repository

import (
	"context"

	"github.com/google/uuid"
)

type FollowshipsRepo interface {
	CreateFollowship(ctx context.Context, followed_user_id, following_user_id uuid.UUID) error
	DeleteFollowship(ctx context.Context, followed_user_id, following_user_id uuid.UUID) error
}
