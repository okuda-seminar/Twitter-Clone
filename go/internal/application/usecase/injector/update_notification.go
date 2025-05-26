package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUpdateNotificationUsecase(usersRepository repository.UsersRepository) usecase.UpdateNotificationUsecase {
	return implementation.NewUpdateNotificationUsecase(usersRepository)

}
