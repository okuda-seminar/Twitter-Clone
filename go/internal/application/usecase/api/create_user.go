package api

import (
	"x-clone-backend/internal/domain/entity"
)

type CreateUserUsecase interface {
	CreateUser(username, displayName, password string) (entity.User, error)

	SetError(err error)
	ClearError()
}
