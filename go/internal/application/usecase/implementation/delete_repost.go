package implementation

import (
	"context"

	usecase "x-clone-backend/internal/application/usecase/api"
	domainmessaging "x-clone-backend/internal/domain/messaging"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/messaging"
)

type deleteRepostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
	timelineProducer        *messaging.KafkaTimelineItemEventProducer
}

func NewDeleteRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository, timelineProducer *messaging.KafkaTimelineItemEventProducer) usecase.DeleteRepostUsecase {
	return &deleteRepostUsecase{
		timelineItemsRepository,
		timelineProducer,
	}
}

func (u *deleteRepostUsecase) DeleteRepost(repostID string) error {
	err := u.timelineItemsRepository.DeleteRepost(repostID)
	if err != nil {
		return err
	}

	// Publish a delete event to Kafka
	err = u.timelineProducer.PublishDeleteRepostEvent(context.Background(), domainmessaging.DeleteRepostMessage{PostID: repostID})
	if err != nil {
		return err
	}

	return nil
}

func (u *deleteRepostUsecase) SetError(err error) {}
func (u *deleteRepostUsecase) ClearError()        {}
