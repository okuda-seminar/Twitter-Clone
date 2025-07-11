package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type specificUserPostsUsecase struct {
	timelineitemsRepository repository.TimelineItemsRepository
}

func NewSpecificUserPostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.SpecificUserPostsUsecase {
	return &specificUserPostsUsecase{timelineitemsRepository: timelineitemsRepository}
}

func (u *specificUserPostsUsecase) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	timelineitems, err := u.timelineitemsRepository.SpecificUserPosts(userID)
	if err != nil {
		return nil, err
	}

	return timelineitems, nil
}

func (u *specificUserPostsUsecase) SetError(err error)                    {}
func (u *specificUserPostsUsecase) ClearError()                           {}
func (u *specificUserPostsUsecase) SetPosts(posts []*entity.TimelineItem) {}
