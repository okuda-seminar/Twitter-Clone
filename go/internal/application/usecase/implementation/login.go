package implementation

import (
	"errors"

	"x-clone-backend/internal/application/service"
	usecase "x-clone-backend/internal/application/usecase/api"
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

func (u *loginUsecase) Login(username, password string) (entity.User, string, error) {
	user, err := u.usersRepository.UserByUsername(nil, username)
	if err != nil {
		if errors.Is(err, repository.ErrRecordNotFound) {
			return entity.User{}, "", usecase.ErrUserNotFound
		}
		return entity.User{}, "", err
	}

	if !u.authService.VerifyPassword(user.Password, password) {
		return entity.User{}, "", usecase.ErrInvalidCredentials
	}

	token, err := u.authService.GenerateJWT(user.ID, user.Username)
	if err != nil {
		return entity.User{}, "", usecase.ErrTokenGeneration
	}

	return user, token, nil
}
