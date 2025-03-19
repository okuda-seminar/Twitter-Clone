package usecase

import (
	"x-clone-backend/internal/domain/entity"
)

type UserAndFolloweePostsUsecase interface {
	UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error)
}
