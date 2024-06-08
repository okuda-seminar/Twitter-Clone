package repository

import (
	"context"
	"database/sql"

	"github.com/google/uuid"
)

// retweetRepoImpl implements tweets/repository/retweetsRepo.
type retweetsRepoImpl struct {
	db *sql.DB
}

// NewRetweetsRepoImpl returns the retweets repository implementation.
func NewRetweetsRepoImpl(db *sql.DB) RetweetsRepo {
	return &retweetsRepoImpl{db}
}

// CreateRetweet creates a new retweet entry and inserts it into 'retweets' table.
func (r *retweetsRepoImpl) CreateRetweet(ctx context.Context, tweet_id, user_id uuid.UUID) error {
	query := "INSERT INTO retweets (tweet_id, user_id) VALUES ($1, $2)"
	_, err := r.db.ExecContext(ctx, query, tweet_id, user_id)
	if err != nil {
		return err
	}
	return nil
}

// DeleteRetweet deletes a retweet entry from 'retweets' table.
func (r *retweetsRepoImpl) DeleteRetweet(ctx context.Context, tweet_id, user_id uuid.UUID) error {
	query := "DELETE FROM retweets WHERE tweet_id = $1 and user_id = $2"
	_, err := r.db.ExecContext(ctx, query, tweet_id, user_id)
	if err != nil {
		return err
	}
	return nil
}
