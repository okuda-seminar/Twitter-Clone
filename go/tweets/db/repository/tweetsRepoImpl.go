package repository

import (
	"context"
	"database/sql"
)

// tweetsRepoImpl implements tweets/repository/tweetsRepo.
type tweetsRepoImpl struct {
	db *sql.DB
}

// NewTweetsRepoImpl returns the tweets repository implementation.
func NewTweetsRepoImpl(db *sql.DB) TweetsRepo {
	return &tweetsRepoImpl{db}
}

// CreateTweet creates a new tweet entry and inserts it into 'tweets' table.
func (r *tweetsRepoImpl) CreateTweet(ctx context.Context, user_id int, text string) (*Tweet, error) {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/69
	// [go/tweets] Implement CreateTweet API logic
	return nil, nil
}
