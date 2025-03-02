package usecases

import (
	domainerrors "x-clone-backend/internal/app/errors"
	"x-clone-backend/internal/app/services"
	"x-clone-backend/internal/domain/entities"
	"x-clone-backend/internal/domain/repositories"
)

type LoginUseCase interface {
	Login(username, password string) (entities.User, string, error)
}

type loginUseCase struct {
	usersRepository repositories.UsersRepositoryInterface
	authService     *services.AuthService
}

func NewLoginUseCase(usersRepository repositories.UsersRepositoryInterface, authService *services.AuthService) LoginUseCase {
	return &loginUseCase{
		usersRepository: usersRepository,
		authService:     authService,
	}
}

func (p *loginUseCase) Login(username, password string) (entities.User, string, error) {
	user, err := p.usersRepository.UserByUsername(nil, username)
	if err != nil {
		return entities.User{}, "", domainerrors.ErrUserNotFound
	}

	if !p.authService.VerifyPassword(user.Password, password) {
		return entities.User{}, "", domainerrors.ErrInvalidCredentials
	}

	token, err := p.authService.GenerateJWT(user.ID, user.Username)
	if err != nil {
		return entities.User{}, "", domainerrors.ErrTokenGeneration
	}

	return user, token, nil
}
