package repository

import (
	"context"

	"github.com/google/uuid"
)

type MutesRepo interface {
	CreateMute(ctx context.Context, muted_user_id, muting_user_id uuid.UUID) error
	DeleteMute(ctx context.Context, muted_user_id, muting_user_id uuid.UUID) error
}
