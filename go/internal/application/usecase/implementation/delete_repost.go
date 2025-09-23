package implementation

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/repository"
)

type deleteRepostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
}

func NewDeleteRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository) usecase.DeleteRepostUsecase {
	return &deleteRepostUsecase{
		timelineItemsRepository,
	}
}

func (u *deleteRepostUsecase) DeleteRepost(repostID string) error {
	return u.timelineItemsRepository.DeleteRepost(repostID)
}

func (u *deleteRepostUsecase) SetError(err error) {}
func (u *deleteRepostUsecase) ClearError()        {}
