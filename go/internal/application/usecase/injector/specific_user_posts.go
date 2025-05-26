package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectSpecificUserPostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.SpecificUserPostsUsecase {
	return implementation.NewSpecificUserPostsUsecase(timelineitemsRepository)
}
