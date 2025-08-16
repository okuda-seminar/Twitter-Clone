package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectGetPostByPostIDUsecase(timelineItemsRepository *repository.TimelineItemsRepository) usecase.GetPostByPostIDUsecase {
	return implementation.NewGetPostByPostIDUsecase(*timelineItemsRepository)
}
