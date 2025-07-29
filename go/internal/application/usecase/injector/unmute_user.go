package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUnmuteUserUsecase(usersRepository repository.UsersRepository) usecase.UnmuteUserUsecase {
	if testing.Testing() {
		return fake.NewFakeUnmuteUserUsecase()
	}
	return implementation.NewUnmuteUserUsecase(usersRepository)
}
