package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectCreateQuoteRepostUsecase(timelineItemsRepository repository.TimelineItemsRepository) usecase.CreateQuoteRepostUsecase {
	return implementation.NewCreateQuoteRepostUsecase(timelineItemsRepository)
}
