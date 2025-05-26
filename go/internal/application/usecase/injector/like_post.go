package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectLikePostUsecase(usersRepository repository.UsersRepository) usecase.LikePostUsecase {
	return implementation.NewLikePostUsecase(usersRepository)
}
