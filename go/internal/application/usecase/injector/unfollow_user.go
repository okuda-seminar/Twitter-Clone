package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUnfollowUserUsecase(usersRepository repository.UsersRepository) usecase.UnfollowUserUsecase {
	return implementation.NewUnfollowUserUsecase(usersRepository)
}
