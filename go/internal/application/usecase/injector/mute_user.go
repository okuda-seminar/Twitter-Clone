package injector

import (
	"testing"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/fake"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectMuteUserUsecase(usersRepository repository.UsersRepository) usecase.MuteUserUsecase {
	if testing.Testing() {
		return fake.NewFakeMuteUserUsecase()
	}
	return implementation.NewMuteUserUsecase(usersRepository)
}
