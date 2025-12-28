package usecase

import (
	"context"

	"x-clone-backend/internal/domain/messaging"
	"x-clone-backend/internal/infrastructure/cache"
	"x-clone-backend/internal/worker/usecase/api"
)

type timelineUsecase struct {
	cacheRepo cache.CacheTimelineItemsRepository
}

func NewTimelineUsecase(cacheRepo cache.CacheTimelineItemsRepository) api.TimelineUsecase {
	return &timelineUsecase{
		cacheRepo: cacheRepo,
	}
}

// DeletePost removes a post from the timeline cache
func (u *timelineUsecase) DeletePost(ctx context.Context, input messaging.DeletePostMessage) error {

	if err := u.cacheRepo.DeletePost(input.PostID); err != nil {
		return err
	}

	return nil
}
