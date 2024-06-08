package repository

import (
	"context"
	"database/sql"

	"github.com/google/uuid"
)

// likesRepoImpl implements tweets/repository/likesRepo.
type likesRepoImpl struct {
	db *sql.DB
}

// NewLikesRepoImpl returns the likes repository implementation.
func NewLikesRepoImpl(db *sql.DB) LikesRepo {
	return &likesRepoImpl{db}
}

// CreateLike creates a new like entry and inserts it into 'likes' table.
func (r *likesRepoImpl) CreateLike(ctx context.Context, tweet_id, user_id uuid.UUID) error {
	query := "INSERT INTO likes (tweet_id, user_id) VALUES ($1, $2)"
	_, err := r.db.ExecContext(ctx, query, tweet_id, user_id)
	if err != nil {
		return err
	}
	return nil
}

// DeleteLike deletes a like entry from 'likes' table.
func (r *likesRepoImpl) DeleteLike(ctx context.Context, tweet_id, user_id uuid.UUID) error {
	query := "DELETE FROM likes WHERE tweet_id = $1 and user_id = $2"
	_, err := r.db.ExecContext(ctx, query, tweet_id, user_id)
	if err != nil {
		return err
	}

	return nil
}
