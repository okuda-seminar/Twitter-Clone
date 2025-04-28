package interactor

import (
	"errors"

	"github.com/google/uuid"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createPostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
}

func NewCreatePostUsecase(timelineItemsRepository repository.TimelineItemsRepository) usecase.CreatePostUsecase {
	return &createPostUsecase{
		timelineItemsRepository: timelineItemsRepository,
	}
}

func (u createPostUsecase) CreatePost(userID uuid.UUID, text string) (entity.TimelineItem, error) {
	var post entity.TimelineItem

	if len(text) > entity.PostTextMaxLength {
		return post, usecase.ErrTooLongText
	}

	post, err := u.timelineItemsRepository.CreatePost(userID, text)
	if err != nil {
		if errors.Is(err, repository.ErrForeignViolation) {
			return post, usecase.ErrUserNotFound
		}
		return post, err
	}

	return post, nil
}
