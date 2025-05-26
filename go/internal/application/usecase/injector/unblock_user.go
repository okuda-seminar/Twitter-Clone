package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUnblockUserUsecase(usersRepository repository.UsersRepository) usecase.UnblockUserUsecase {
	return implementation.NewUnblockUserUsecase(usersRepository)
}
