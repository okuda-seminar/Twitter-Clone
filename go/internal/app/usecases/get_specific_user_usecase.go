package usecases

import (
	"x-clone-backend/internal/domain/entities"
	"x-clone-backend/internal/domain/repositories"
)

type GetSpecificUserUsecase interface {
	GetSpecificUser(userID string) (entities.User, error)
}

type getSpecificUserUsecase struct {
	usersRepository repositories.UsersRepositoryInterface
}

func NewGetSpecificUserUsecase(usersRepository repositories.UsersRepositoryInterface) GetSpecificUserUsecase {
	return &getSpecificUserUsecase{usersRepository: usersRepository}
}

func (p *getSpecificUserUsecase) GetSpecificUser(userID string) (entities.User, error) {
	user, err := p.usersRepository.GetSpecificUser(nil, userID)
	if err != nil {
		return entities.User{}, err
	}

	return user, nil
}
