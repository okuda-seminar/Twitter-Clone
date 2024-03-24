package repository

import (
	"context"
	"time"
)

type TweetsRepo interface {
	CreateTweet(ctx context.Context, user_id int, text string) (*Tweet, error)
}

// Tweet represents an entry of 'tweets' table.
type Tweet struct {
	Id        int
	UserId    int
	Text      string
	CreatedAt time.Time
}
