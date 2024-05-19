package repository

import "context"

type LikesRepo interface {
	CreateLike(ctx context.Context, tweet_id string, user_id string) error
}
