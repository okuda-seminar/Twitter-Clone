package api

import "x-clone-backend/internal/domain/entity"

type CreateRepostUsecase interface {
	CreateRepost(userID, postID string) (entity.TimelineItem, error)

	SetError(err error)
	ClearError()
}
