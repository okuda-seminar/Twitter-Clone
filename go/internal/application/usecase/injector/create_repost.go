package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectCreateRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository, usersRepository repository.UsersRepository) usecase.CreateRepostUsecase {
	if testing.Testing() {
		return fake.NewFakeCreateRepostUsecase()
	}
	return implementation.NewCreateRepostUsecase(timelineItemsRepository, usersRepository)
}
