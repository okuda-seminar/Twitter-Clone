package repository

import (
	"context"
	"database/sql"
)

type followshipsRepoImpl struct {
	db *sql.DB
}

func NewFollowshipsRepoImpl(db *sql.DB) FollowshipsRepo {
	return &followshipsRepoImpl{db}
}

func (r *followshipsRepoImpl) CreateFollowship(
	ctx context.Context, follower_id, followee_id string) error {
	query := "INSERT INTO followships (follower_id, followee_id) VALUES ($1, $2)"
	_, err := r.db.ExecContext(ctx, query, follower_id, followee_id)
	if err != nil {
		return err
	}
	return nil
}

func (r *followshipsRepoImpl) DeleteFollowship(
	ctx context.Context, follower_id, followee_id string) error {
	query := "DELETE FROM followships WHERE follower_id = $1 and followee_id = $2"
	_, err := r.db.ExecContext(ctx, query, follower_id, followee_id)
	if err != nil {
		return err
	}

	return nil
}
