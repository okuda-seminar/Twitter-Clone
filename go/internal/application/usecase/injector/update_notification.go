package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUpdateNotificationUsecase(usersRepository repository.UsersRepository) usecase.UpdateNotificationUsecase {
	if testing.Testing() {
		return fake.NewFakeUpdateNotificationUsecase()
	}
	return implementation.NewUpdateNotificationUsecase(usersRepository)
}
