package injector

import (
	"x-clone-backend/internal/application/service"
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/implementation"
	"x-clone-backend/internal/domain/repository"
)

func InjectLoginUsecase(usersRepository repository.UsersRepository, authService *service.AuthService) usecase.LoginUsecase {
	return implementation.NewLoginUsecase(usersRepository, authService)
}
