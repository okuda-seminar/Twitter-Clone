package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectBlockUserUsecase(usersRepository repository.UsersRepository) usecase.BlockUserUsecase {
	return implementation.NewBlockUserUsecase(usersRepository)
}
