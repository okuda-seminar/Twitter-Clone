package api

import "x-clone-backend/internal/domain/entity"

type GetPostByPostIDUsecase interface {
	GetPostAndParentPostByPostID(postID string) (timelineItem *entity.TimelineItem, parentTimelineItem *entity.TimelineItem, err error)
}
