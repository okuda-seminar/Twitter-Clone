package repository

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/google/uuid"
)

// repliesRepoImpl implements tweets/repository/repliesRepo.
type repliesRepoImpl struct {
	db *sql.DB
}

// NewRepliesRepoImpl returns the replies repository implementation.
func NewRepliesRepoImpl(db *sql.DB) RepliesRepo {
	return &repliesRepoImpl{db}
}

// CreateReply creates a new reply entry and inserts it into 'replies' table.
func (r *repliesRepoImpl) CreateReply(
	ctx context.Context,
	tweet_id uuid.UUID,
	user_id uuid.UUID,
	text string,
) (*Reply, error) {
	query := "INSERT INTO replies (id, tweet_id, user_id, text) VALUES ($1, $2, $3, $4) RETURNING created_at"
	var created_at time.Time
	id := uuid.New()

	err := r.db.QueryRowContext(ctx, query, id, tweet_id, user_id, text).Scan(&created_at)
	if err != nil {
		return nil, err
	}

	reply := Reply{
		Id:        id,
		TweetId:   tweet_id,
		UserId:    user_id,
		Text:      text,
		CreatedAt: created_at,
	}

	return &reply, nil
}

// DeleteReply deletes a reply with the specified reply ID.
func (r *repliesRepoImpl) DeleteReply(
	ctx context.Context,
	id uuid.UUID,
) error {
	query := "DELETE FROM replies WHERE id = $1"
	res, err := r.db.ExecContext(ctx, query, id)
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.New("no row found to delete")
	}

	return nil
}
