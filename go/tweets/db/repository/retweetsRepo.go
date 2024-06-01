package repository

import "context"

type RetweetsRepo interface {
	CreateRetweet(ctx context.Context, tweet_id string, user_id string) error
	DeleteRetweet(ctx context.Context, tweet_id string, user_id string) error
}
