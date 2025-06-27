package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectLikePostUsecase(usersRepository repository.UsersRepository) usecase.LikePostUsecase {
	if testing.Testing() {
		return fake.NewFakeLikePostUsecase()
	}
	return implementation.NewLikePostUsecase(usersRepository)
}
