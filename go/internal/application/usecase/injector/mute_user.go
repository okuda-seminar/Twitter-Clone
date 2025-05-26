package injector

import (
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectMuteUserUsecase(usersRepository repository.UsersRepository) usecase.MuteUserUsecase {
	return implementation.NewMuteUserUsecase(usersRepository)
}
