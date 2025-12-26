package implementation

import (
	"context"

	usecase "x-clone-backend/internal/application/usecase/api"
	domainmessaging "x-clone-backend/internal/domain/messaging"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/messaging"
)

type deletePostUsecase struct {
	timelineItemsRepository repository.TimelineItemsRepository
	timelineProducer        *messaging.KafkaTimelineItemEventProducer
}

func NewDeletePostUsecase(timelineItemsRepository repository.TimelineItemsRepository, timelineProducer *messaging.KafkaTimelineItemEventProducer) usecase.DeletePostUsecase {
	return &deletePostUsecase{
		timelineItemsRepository: timelineItemsRepository,
		timelineProducer:        timelineProducer,
	}
}

func (u *deletePostUsecase) DeletePost(postID string) error {
	err := u.timelineItemsRepository.DeletePost(postID)
	if err != nil {
		return err
	}

	// Publish a delete event to Kafka
	err = u.timelineProducer.PublishDeleteTimelineItemEvent(context.Background(), domainmessaging.DeletePostMessage{PostID: postID})
	if err != nil {
		return err
	}

	return nil
}

func (u *deletePostUsecase) SetError(err error) {}
func (u *deletePostUsecase) ClearError()        {}
