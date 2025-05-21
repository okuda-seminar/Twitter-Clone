package api

import "x-clone-backend/internal/domain/entity"

type CreateQuoteRepostUsecase interface {
	CreateQuoteRepost(userID, postID, text string) (entity.TimelineItem, error)
}
