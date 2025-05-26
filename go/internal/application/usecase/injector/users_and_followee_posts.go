package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUserAndFolloweePostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.UserAndFolloweePostsUsecase {
	return implementation.NewUserAndFolloweePostsUsecase(timelineitemsRepository)
}
