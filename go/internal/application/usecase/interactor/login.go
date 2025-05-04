package interactor

import (
	"errors"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type loginUsecase struct {
	usersRepository repository.UsersRepository
	authService     *service.AuthService
}

func NewLoginUsecase(usersRepository repository.UsersRepository, authService *service.AuthService) usecase.LoginUsecase {
	return &loginUsecase{
		usersRepository: usersRepository,
		authService:     authService,
	}
}

func (p *loginUsecase) Login(username, password string) (entity.User, string, error) {
	user, err := p.usersRepository.UserByUsername(nil, username)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			return entity.User{}, "", usecase.ErrUserNotFound
		}
		return entity.User{}, "", err
	}

	if !p.authService.VerifyPassword(user.Password, password) {
		return entity.User{}, "", usecase.ErrInvalidCredentials
	}

	token, err := p.authService.GenerateJWT(user.ID, user.Username)
	if err != nil {
		return entity.User{}, "", usecase.ErrTokenGeneration
	}

	return user, token, nil
}
