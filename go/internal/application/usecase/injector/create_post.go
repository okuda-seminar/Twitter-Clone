package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectCreatePostUsecase(timelineItemsRepository repository.TimelineItemsRepository, usersRepository repository.UsersRepository) usecase.CreatePostUsecase {
	return implementation.NewCreatePostUsecase(timelineItemsRepository, usersRepository)
}
