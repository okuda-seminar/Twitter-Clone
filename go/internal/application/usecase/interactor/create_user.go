package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewCreateUserUsecase(usersRepository repository.UsersRepository) usecase.CreateUserUsecase {
	return &createUserUsecase{usersRepository: usersRepository}
}

func (p *createUserUsecase) CreateUser(username, displayName, hashedPassword string) (entity.User, error) {
	var user entity.User
	user, err := p.usersRepository.CreateUser(nil, username, displayName, hashedPassword)
	if err != nil {
		return entity.User{}, err
	}

	return user, nil
}
