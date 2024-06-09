package repository

import (
	"context"
	"database/sql"

	"github.com/google/uuid"
)

type mutesRepoImpl struct {
	db *sql.DB
}

func NewMutesRepoImpl(db *sql.DB) MutesRepo {
	return &mutesRepoImpl{db}
}

func (r *mutesRepoImpl) CreateMute(ctx context.Context, muted_user_id, muting_user_id uuid.UUID) error {
	query := `
		INSERT INTO mutes (muted_user_id, muting_user_id)
		VALUES ($1, $2)
	`
	_, err := r.db.ExecContext(ctx, query, muted_user_id, muting_user_id)
	if err != nil {
		return err
	}
	return nil
}

func (r *mutesRepoImpl) DeleteMute(ctx context.Context, muted_user_id, muting_user_id uuid.UUID) error {
	query := `
		DELETE FROM mutes
		WHERE muted_user_id = $1 AND muting_user_id = $2
	`
	_, err := r.db.ExecContext(ctx, query, muted_user_id, muting_user_id)
	if err != nil {
		return err
	}
	return nil
}
