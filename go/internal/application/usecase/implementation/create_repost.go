package implementation

import (
	"x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createRepostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
	usersRepository         repository.UsersRepository
}

func NewCreateRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository, usersRepository repository.UsersRepository) api.CreateRepostUsecase {
	return &createRepostUsecase{
		timelineItemsRepository: timelineItemsRepository,
		usersRepository:         usersRepository,
	}
}

func (u *createRepostUsecase) CreateRepost(userID, postID string) (entity.TimelineItem, error) {
	// Get followers for timeline cache
	users, err := u.usersRepository.FollowersByID(nil, userID)
	if err != nil {
		return entity.TimelineItem{}, err
	}

	userIDs := make([]string, 0, len(users)+1)
	for _, user := range users {
		userIDs = append(userIDs, user.ID)
	}
	userIDs = append(userIDs, userID)

	repost, err := u.timelineItemsRepository.CreateRepost(userID, postID, userIDs)
	if err != nil {
		return entity.TimelineItem{}, err
	}

	return repost, nil
}

func (u *createRepostUsecase) SetError(err error) {}
func (u *createRepostUsecase) ClearError()        {}
