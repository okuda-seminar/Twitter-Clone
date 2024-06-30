package repository

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type TweetsRepo interface {
	CreatePost(ctx context.Context, user_id uuid.UUID, text string) (*Tweet, error)
	DeleteTweet(ctx context.Context, id uuid.UUID) error
}

// Tweet represents an entry of 'tweets' table.
type Tweet struct {
	Id        uuid.UUID
	UserId    uuid.UUID
	Text      string
	CreatedAt time.Time
}
