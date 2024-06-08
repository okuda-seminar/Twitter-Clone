package repository

import (
	"context"

	"github.com/google/uuid"
)

type RetweetsRepo interface {
	CreateRetweet(ctx context.Context, tweet_id uuid.UUID, user_id uuid.UUID) error
	DeleteRetweet(ctx context.Context, tweet_id uuid.UUID, user_id uuid.UUID) error
}
