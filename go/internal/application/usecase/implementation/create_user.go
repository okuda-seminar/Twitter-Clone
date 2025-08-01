package implementation

import (
	"errors"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type createUserUsecase struct {
	usersRepository repository.UsersRepository
}

func NewCreateUserUsecase(usersRepository repository.UsersRepository) usecase.CreateUserUsecase {
	return &createUserUsecase{usersRepository: usersRepository}
}

func (u *createUserUsecase) CreateUser(username, displayName, hashedPassword string) (entity.User, error) {
	var user entity.User
	user, err := u.usersRepository.CreateUser(nil, username, displayName, hashedPassword)
	if err != nil {
		if errors.Is(err, repository.ErrUniqueViolation) {
			return entity.User{}, usecase.ErrUserAlreadyExists
		}
		return entity.User{}, err
	}

	return user, nil
}

func (u *createUserUsecase) SetError(err error) {}
func (u *createUserUsecase) ClearError()        {}
