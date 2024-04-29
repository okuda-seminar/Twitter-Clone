package repository

import (
	"context"
	"database/sql"
	"time"
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
	query := "INSERT INTO tweets (user_id, text) VALUES ($1, $2) RETURNING id, created_at"
	var (
		id int
		created_at time.Time)

	err := r.db.QueryRowContext(ctx, query, user_id, text).Scan(&id, &created_at)
	if err != nil {
		return nil, err
	}

	tweet := Tweet{
		Id: 		id,
		UserId: 	user_id,
		Text: 		text,
		CreatedAt: 	created_at,
	}


	return &tweet, nil
}
