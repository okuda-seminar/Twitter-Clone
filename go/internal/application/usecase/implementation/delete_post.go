package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type deletePostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
}

func NewDeletePostUsecase(timelineItemsRepository repository.TimelineItemsRepository) usecase.DeletePostUsecase {
	return &deletePostUsecase{
		timelineItemsRepository,
	}
}

func (u *deletePostUsecase) DeletePost(postID string) error {
	return u.timelineItemsRepository.DeletePost(postID)
}

func (u *deletePostUsecase) SetError(err error) {}
func (u *deletePostUsecase) ClearError()        {}
