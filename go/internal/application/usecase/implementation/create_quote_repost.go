package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createQuoteRepostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
	usersRepository         repository.UsersRepository
}

func NewCreateQuoteRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository, usersRepository repository.UsersRepository) usecase.CreateQuoteRepostUsecase {
	return &createQuoteRepostUsecase{
		timelineItemsRepository: timelineItemsRepository,
		usersRepository:         usersRepository,
	}
}

func (u createQuoteRepostUsecase) CreateQuoteRepost(userID, postID, text string) (entity.TimelineItem, error) {
	if len(text) > entity.PostTextMaxLength {
		return entity.TimelineItem{}, usecase.ErrTooLongText
	}

	parentPost, err := u.timelineItemsRepository.TimelineItemByID(postID)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			return entity.TimelineItem{}, usecase.ErrTimelineItemNotFound
		}
		return entity.TimelineItem{}, err
	}
	if parentPost.Type == entity.PostTypeRepost {
		return entity.TimelineItem{}, usecase.ErrRepostViolation
	}

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

	quoteRepost, err := u.timelineItemsRepository.CreateQuoteRepost(userID, postID, text, userIDs)
	if err != nil {
		if errors.Is(err, repository.ErrForeignViolation) {
			return quoteRepost, usecase.ErrUserNotFound
		}
		return quoteRepost, err
	}

	return quoteRepost, nil
}
