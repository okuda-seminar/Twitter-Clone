package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createQuoteRepostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
}

func NewCreateQuoteRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository) usecase.CreateQuoteRepostUsecase {
	return &createQuoteRepostUsecase{
		timelineItemsRepository: timelineItemsRepository,
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

	quoteRepost, err := u.timelineItemsRepository.CreateQuoteRepost(userID, postID, text)
	if err != nil {
		if errors.Is(err, repository.ErrForeignViolation) {
			return quoteRepost, usecase.ErrUserNotFound
		}
		return quoteRepost, err
	}

	return quoteRepost, nil
}
