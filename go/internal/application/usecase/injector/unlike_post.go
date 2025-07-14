package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUnlikePostUsecase(usersRepository repository.UsersRepository) usecase.UnlikePostUsecase {
	if testing.Testing() {
		return fake.NewFakeUnlikePostUsecase()
	}
	return implementation.NewUnlikePostUsecase(usersRepository)

}
