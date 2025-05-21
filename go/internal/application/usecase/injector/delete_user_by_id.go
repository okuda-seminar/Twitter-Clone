package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectDeleteUserByIDUsecase(usersRepository repository.UsersRepository) usecase.DeleteUserByIDUsecase {
	if testing.Testing() {
		return fake.NewFakeDeleteUserByIDUsecase()
	}
	return implementation.NewDeleteUserByIDUsecase(usersRepository)
}
