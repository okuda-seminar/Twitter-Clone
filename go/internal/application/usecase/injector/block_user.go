package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectBlockUserUsecase(usersRepository repository.UsersRepository) usecase.BlockUserUsecase {
	if testing.Testing() {
		return fake.NewFakeBlockUserUsecase()
	}
	return implementation.NewBlockUserUsecase(usersRepository)
}
