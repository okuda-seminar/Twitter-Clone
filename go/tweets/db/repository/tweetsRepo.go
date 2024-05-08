package repository

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type TweetsRepo interface {
	CreateTweet(ctx context.Context, user_id uuid.UUID, text string) (*Tweet, error)
}

// Tweet represents an entry of 'tweets' table.
type Tweet struct {
	Id        uuid.UUID
	UserId    uuid.UUID
	Text      string
	CreatedAt time.Time
}
