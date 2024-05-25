package repository

import "context"

type MutesRepo interface {
	CreateMute(ctx context.Context, muted_user_id, muting_user_id string) error
	DeleteMute(ctx context.Context, muted_user_id, muting_user_id string) error
}
