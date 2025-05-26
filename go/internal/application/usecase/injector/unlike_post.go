package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUnlikePostUsecase(usersRepository repository.UsersRepository) usecase.UnlikePostUsecase {
	return implementation.NewUnlikePostUsecase(usersRepository)

}
