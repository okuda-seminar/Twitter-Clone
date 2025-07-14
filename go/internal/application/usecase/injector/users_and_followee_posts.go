package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUserAndFolloweePostsUsecase(timelineitemsRepository repository.TimelineItemsRepository) usecase.UserAndFolloweePostsUsecase {
	if testing.Testing() {
		return fake.NewFakeUserAndFolloweePostsUsecase()
	}
	return implementation.NewUserAndFolloweePostsUsecase(timelineitemsRepository)
}
