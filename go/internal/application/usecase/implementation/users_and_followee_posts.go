package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type userAndFolloweePostsUsecase struct {
	timelineitemsRepository repository.TimelineItemsRepository
}

func NewUserAndFolloweePostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.UserAndFolloweePostsUsecase {
	return &userAndFolloweePostsUsecase{timelineitemsRepository: timelineitemsRepository}
}

func (u *userAndFolloweePostsUsecase) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
	timelineitems, err := u.timelineitemsRepository.UserAndFolloweePosts(userID)
	if err != nil {
		return nil, err
	}

	return timelineitems, nil
}
