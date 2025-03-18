package interactor

import (
	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type loginUsecase struct {
	usersRepository repository.UsersRepository
	authService     *service.AuthService
}

func NewLoginUseCase(usersRepository repository.UsersRepository, authService *service.AuthService) usecase.LoginUsecase {
	return &loginUsecase{
		usersRepository: usersRepository,
		authService:     authService,
	}
}

func (p *loginUsecase) Login(username, password string) (entity.User, string, error) {
	user, err := p.usersRepository.UserByUsername(nil, username)
	if err != nil {
		return entity.User{}, "", domain.ErrUserNotFound
	}

	if !p.authService.VerifyPassword(user.Password, password) {
		return entity.User{}, "", domain.ErrInvalidCredentials
	}

	token, err := p.authService.GenerateJWT(user.ID, user.Username)
	if err != nil {
		return entity.User{}, "", domain.ErrTokenGeneration
	}

	return user, token, nil
}
