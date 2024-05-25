package repository

import (
	"context"
	"database/sql"
)

type mutesRepoImpl struct {
	db *sql.DB
}

func NewMutesRepoImpl(db *sql.DB) MutesRepo {
	return &mutesRepoImpl{db}
}

func (r *mutesRepoImpl) CreateMute(ctx context.Context, muted_user_id, muting_user_id string) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/204
	// - Implement Mute and Unmute API logic.
	return nil
}

func (r *mutesRepoImpl) DeleteMute(ctx context.Context, muted_user_id, muting_user_id string) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/204
	// - Implement Mute and Unmute API logic.
	return nil
}
