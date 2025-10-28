package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type userByUserIDUsecase struct {
	usersRepository         repository.UsersRepository
	timelineItemsRepository repository.TimelineItemsRepository
}

func NewUserByUserIDUsecase(usersRepository repository.UsersRepository, timelineItemsRepository repository.TimelineItemsRepository) usecase.UserByUserIDUsecase {
	return &userByUserIDUsecase{usersRepository, timelineItemsRepository}
}

func (u *userByUserIDUsecase) UserByUserID(userID string) (user entity.UserProfile, err error) {
	profileBaseInfo, err := u.usersRepository.UserByUserID(nil, userID)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			return entity.UserProfile{}, usecase.ErrUserNotFound
		}
		return entity.UserProfile{}, err
	}

	postsCount, err := u.timelineItemsRepository.CountPosts(userID)
	if err != nil {
		return entity.UserProfile{}, err
	}

	return entity.UserProfile{ProfileBaseInfo: profileBaseInfo, PostsCount: postsCount}, nil
}

func (u *userByUserIDUsecase) SetError(err error)                     {}
func (u *userByUserIDUsecase) ClearError()                            {}
func (u *userByUserIDUsecase) SetUser(userProfile entity.UserProfile) {}
