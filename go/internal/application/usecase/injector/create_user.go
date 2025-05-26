package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectCreateUserUsecase(usersRepository repository.UsersRepository) usecase.CreateUserUsecase {
	return implementation.NewCreateUserUsecase(usersRepository)
}
