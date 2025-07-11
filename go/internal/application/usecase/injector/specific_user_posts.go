package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectSpecificUserPostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.SpecificUserPostsUsecase {
	if testing.Testing() {
		return fake.NewFakeSpecificUserPostsUsecase()
	}
	return implementation.NewSpecificUserPostsUsecase(timelineitemsRepository)
}
