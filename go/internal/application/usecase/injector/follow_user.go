package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectFollowUserUsecase(usersRepository repository.UsersRepository) usecase.FollowUserUsecase {
	return implementation.NewFollowUserUsecase(usersRepository)
}
