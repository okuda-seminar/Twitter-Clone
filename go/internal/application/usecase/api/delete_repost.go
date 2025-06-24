package api

import "x-clone-backend/internal/domain/entity"

type DeleteRepostUsecase interface {
	DeleteRepost(repostID string) (entity.TimelineItem, error)

	SetError(err error)
	ClearError()
}
