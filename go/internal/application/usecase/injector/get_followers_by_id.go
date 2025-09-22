package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectGetFollowersByIDUsecase(usersRepository repository.UsersRepository) usecase.GetFollowersByIDUsecase {
	if testing.Testing() {
		return fake.NewFakeGetFollowersByIDUsecase()
	}
	return implementation.NewGetFollowersByIDUsecase(usersRepository)
}
