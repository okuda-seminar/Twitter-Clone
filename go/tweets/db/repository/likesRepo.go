package repository

import (
	"context"

	"github.com/google/uuid"
)

type LikesRepo interface {
	CreateLike(ctx context.Context, tweet_id, user_id uuid.UUID) error
	DeleteLike(ctx context.Context, tweet_id, user_id uuid.UUID) error
}
