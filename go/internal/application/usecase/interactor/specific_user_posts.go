package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type specificUserPostsUsecase struct {
	timelineitemsRepository repository.TimelineItemsRepository
}

func NewSpecificUserPostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.SpecificUserPostsUsecase {
	return &specificUserPostsUsecase{timelineitemsRepository: timelineitemsRepository}
}

func (p *specificUserPostsUsecase) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	timelineitems, err := p.timelineitemsRepository.SpecificUserPosts(userID)
	if err != nil {
		return nil, err
	}

	return timelineitems, nil
}
