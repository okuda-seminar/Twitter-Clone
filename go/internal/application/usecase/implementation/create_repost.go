package implementation

import (
	"x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createRepostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
}

func NewCreateRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository) api.CreateRepostUsecase {
	return &createRepostUsecase{
		timelineItemsRepository,
	}
}

func (u *createRepostUsecase) CreateRepost(userID, postID string) (entity.TimelineItem, error) {
	repost, err := u.timelineItemsRepository.CreateRepost(userID, postID)
	if err != nil {
		return entity.TimelineItem{}, err
	}

	return repost, nil
}

func (u *createRepostUsecase) SetError(err error) {}
func (u *createRepostUsecase) ClearError()        {}
