package repository

import (
	"context"
	"database/sql"

	"github.com/google/uuid"
)

type followshipsRepoImpl struct {
	db *sql.DB
}

func NewFollowshipsRepoImpl(db *sql.DB) FollowshipsRepo {
	return &followshipsRepoImpl{db}
}

func (r *followshipsRepoImpl) CreateFollowship(
	ctx context.Context, followed_user_id, following_user_id uuid.UUID,
) error {
	query := "INSERT INTO followships (followed_user_id, following_user_id) VALUES ($1, $2)"
	_, err := r.db.ExecContext(ctx, query, followed_user_id, following_user_id)
	if err != nil {
		return err
	}
	return nil
}

func (r *followshipsRepoImpl) DeleteFollowship(
	ctx context.Context, followed_user_id, following_user_id uuid.UUID,
) error {
	query := "DELETE FROM followships WHERE followed_user_id = $1 and following_user_id = $2"
	_, err := r.db.ExecContext(ctx, query, followed_user_id, following_user_id)
	if err != nil {
		return err
	}

	return nil
}
