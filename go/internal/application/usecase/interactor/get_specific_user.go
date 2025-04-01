package interactor

import (
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type getSpecificUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewGetSpecificUserUsecase(usersRepository repository.UsersRepository) usecase.GetSpecificUserUsecase {
	return &getSpecificUserUsecase{usersRepository: usersRepository}
}

func (p *getSpecificUserUsecase) GetSpecificUser(userID string) (entity.User, error) {
	user, err := p.usersRepository.UserByUserID(nil, userID)
	if err != nil {
		return entity.User{}, err
	}

	return user, nil
}
