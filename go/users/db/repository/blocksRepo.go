package repository

import "context"

type BlocksRepo interface {
	CreateBlock(ctx context.Context, blocked_user_id, blocking_user_id string) error
	DeleteBlock(ctx context.Context, blocked_user_id, blocking_user_id string) error
}
