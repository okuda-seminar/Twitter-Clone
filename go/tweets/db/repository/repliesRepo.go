package repository

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type RepliesRepo interface {
	CreateReply(ctx context.Context, tweet_id uuid.UUID, user_id uuid.UUID, text string) (*Reply, error)
	DeleteReply(ctx context.Context, id uuid.UUID) error
}

// Reply represents an entry of 'replies' table.
type Reply struct {
	Id        uuid.UUID
	TweetId   uuid.UUID
	UserId    uuid.UUID
	Text      string
	CreatedAt time.Time
}
