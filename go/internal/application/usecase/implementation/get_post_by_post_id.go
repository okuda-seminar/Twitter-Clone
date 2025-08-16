package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type getPostByPostIDUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
}

func NewGetPostByPostIDUsecase(timelineItemsRepository repository.TimelineItemsRepository) usecase.GetPostByPostIDUsecase {
	return &getPostByPostIDUsecase{
		timelineItemsRepository: timelineItemsRepository,
	}
}

// GetPostAndParentPostByPostID returns a post specified by the given post id.
// If the type of it is repost or quote repost, additionally returns the parent post of it.
func (u *getPostByPostIDUsecase) GetPostAndParentPostByPostID(postID string) (timelineItem *entity.TimelineItem, parentTimelineItem *entity.TimelineItem, err error) {
	timelineItem, err = u.timelineItemsRepository.TimelineItemByID(postID)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			return nil, nil, usecase.ErrTimelineItemNotFound
		}
		return nil, nil, err
	}

	if timelineItem.Type == entity.PostTypePost {
		return timelineItem, nil, nil
	}

	parentTimelineItem, err = u.timelineItemsRepository.TimelineItemByID(timelineItem.ParentPostID.UUID)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			// this error means that the parent post is deleted.
			return timelineItem, nil, nil
		}
		return nil, nil, err
	}

	return timelineItem, parentTimelineItem, nil
}
