package api

import (
	"context"

	"x-clone-backend/internal/domain/messaging"
)

type TimelineUsecase interface {
	DeletePost(ctx context.Context, input messaging.DeletePostMessage) error
}
