package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectDeleteUserUsecase(usersRepository repository.UsersRepository) usecase.DeleteUserUsecase {
	return implementation.NewDeleteUserUsecase(usersRepository)
}
