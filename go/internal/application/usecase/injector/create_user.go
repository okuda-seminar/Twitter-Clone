package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectCreateUserUsecase(usersRepository repository.UsersRepository) usecase.CreateUserUsecase {
	if testing.Testing() {
		return fake.NewFakeCreateUserUsecase()
	}
	return implementation.NewCreateUserUsecase(usersRepository)
}
