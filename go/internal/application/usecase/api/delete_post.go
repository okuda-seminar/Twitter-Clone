package api

import "x-clone-backend/internal/domain/entity"

type DeletePostUsecase interface {
	DeletePost(postID string) (entity.TimelineItem, error)

	SetError(err error)
	ClearError()
}
