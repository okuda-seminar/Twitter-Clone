package repository

import (
	"context"

	"github.com/google/uuid"
)

type BlocksRepo interface {
	CreateBlock(ctx context.Context, blocked_user_id, blocking_user_id uuid.UUID) error
	DeleteBlock(ctx context.Context, blocked_user_id, blocking_user_id uuid.UUID) error
}
