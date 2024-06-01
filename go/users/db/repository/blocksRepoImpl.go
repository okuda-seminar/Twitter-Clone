package repository

import (
	"context"
	"database/sql"
)

type blocksRepoImpl struct {
	db *sql.DB
}

func NewBlocksRepoImpl(db *sql.DB) BlocksRepo {
	return &blocksRepoImpl{db}
}

func (r *blocksRepoImpl) CreateBlock(ctx context.Context, blocked_user_id, blocking_user_id string) error {
	query := `
		INSERT INTO blocks (blocked_user_id, blocking_user_id)
		VALUES ($1, $2)
	`
	_, err := r.db.ExecContext(ctx, query, blocked_user_id, blocking_user_id)
	if err != nil {
		return err
	}
	return nil
}

func (r *blocksRepoImpl) DeleteBlock(ctx context.Context, blocked_user_id, blocking_user_id string) error {
	query := `
		DELETE FROM blocks
		WHERE blocked_user_id = $1 AND blocking_user_id = $2
	`
	_, err := r.db.ExecContext(ctx, query, blocked_user_id, blocking_user_id)
	if err != nil {
		return err
	}
	return nil
}
