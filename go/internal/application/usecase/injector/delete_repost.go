package injector

import (
	"testing"

	"x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/messaging"
)

func InjectDeleteRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository, timelineProducer *messaging.KafkaTimelineItemEventProducer) api.DeleteRepostUsecase {
	if testing.Testing() {
		return fake.NewFakeDeleteRepostUsecase()
	}
	return implementation.NewDeleteRepostUsecase(timelineItemsRepository, timelineProducer)
}
