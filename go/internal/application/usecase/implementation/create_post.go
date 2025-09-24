package implementation

import (
	"errors"
	"log"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createPostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
	usersRepository         repository.UsersRepository
}

func NewCreatePostUsecase(timelineItemsRepository repository.TimelineItemsRepository, usersRepository repository.UsersRepository) usecase.CreatePostUsecase {
	return &createPostUsecase{
		timelineItemsRepository: timelineItemsRepository,
		usersRepository:         usersRepository,
	}
}

func (u *createPostUsecase) CreatePost(userID, text string) (entity.TimelineItem, error) {
	var post entity.TimelineItem

	if len(text) > entity.PostTextMaxLength {
		return post, usecase.ErrTooLongText
	}

	users, err := u.usersRepository.FolloweesByID(nil, userID)
	var usersID []string
	if err != nil {
		log.Fatalln(err)
	} else {
		for _, user := range users {
			usersID = append(usersID, user.ID)
		}
	}
	usersID = append(usersID, userID)

	post, err = u.timelineItemsRepository.CreatePost(userID, text, usersID)
	if err != nil {
		if errors.Is(err, repository.ErrForeignViolation) {
			return post, usecase.ErrUserNotFound
		}
		return post, err
	}

	return post, nil
}
