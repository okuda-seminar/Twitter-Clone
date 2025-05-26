package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectUserByUserIDUsecase(usersRepository repository.UsersRepository) usecase.UserByUserIDUsecase {
	return implementation.NewUserByUserIDUsecase(usersRepository)
}
