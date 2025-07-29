package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUnblockUserUsecase(usersRepository repository.UsersRepository) usecase.UnblockUserUsecase {
	if testing.Testing() {
		return fake.NewFakeUnblockUserUsecase()
	}
	return implementation.NewUnblockUserUsecase(usersRepository)
}
