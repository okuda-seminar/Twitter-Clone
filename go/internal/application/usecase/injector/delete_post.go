package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/messaging"
)

func InjectDeletePostUsecase(timelineItemsRepository repository.TimelineItemsRepository, timelineProducer *messaging.KafkaTimelineItemEventProducer) usecase.DeletePostUsecase {
	if testing.Testing() {
		return fake.NewFakeDeletePostUsecase()
	}
	return implementation.NewDeletePostUsecase(timelineItemsRepository, timelineProducer)
}
