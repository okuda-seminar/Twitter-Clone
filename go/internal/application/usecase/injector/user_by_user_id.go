package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUserByUserIDUsecase(usersRepository repository.UsersRepository) usecase.UserByUserIDUsecase {
	if testing.Testing() {
		return fake.NewFakeUserByUserIDUsecase()
	}
	return implementation.NewUserByUserIDUsecase(usersRepository)
}
