package injector

import (
	"testing"

	"x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectDeleteRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository) api.DeleteRepostUsecase {
	if testing.Testing() {
		return fake.NewFakeDeleteRepostUsecase()
	}
	return implementation.NewDeleteRepostUsecase(timelineItemsRepository)
}
