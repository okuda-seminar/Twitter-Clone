package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type userAndFolloweePostsUsecase struct {
	timelineitemsRepository repository.TimelineItemsRepository
}

func NewUserAndFolloweePostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.UserAndFolloweePostsUsecase {
	return &userAndFolloweePostsUsecase{timelineitemsRepository: timelineitemsRepository}
}

func (p *userAndFolloweePostsUsecase) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
	timelineitems, err := p.timelineitemsRepository.UserAndFolloweePosts(userID)
	if err != nil {
		return nil, err
	}

	return timelineitems, nil
}
