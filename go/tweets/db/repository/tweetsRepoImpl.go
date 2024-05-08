package repository

import (
	"context"
	"database/sql"
	"time"

	"github.com/google/uuid"
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
func (r *tweetsRepoImpl) CreateTweet(
	ctx context.Context,
	user_id uuid.UUID,
	text string,
) (*Tweet, error) {
	query := "INSERT INTO tweets (id, user_id, text) VALUES ($1, $2, $3) RETURNING created_at"
	var created_at time.Time
	id := uuid.New()

	err := r.db.QueryRowContext(ctx, query, id, user_id, text).Scan(&created_at)
	if err != nil {
		return nil, err
	}

	tweet := Tweet{
		Id:        id,
		UserId:    user_id,
		Text:      text,
		CreatedAt: created_at,
	}

	return &tweet, nil
}
