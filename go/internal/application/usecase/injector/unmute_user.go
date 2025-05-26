package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUnmuteUserUsecase(usersRepository repository.UsersRepository) usecase.UnmuteUserUsecase {
	return implementation.NewUnmuteUserUsecase(usersRepository)
}
