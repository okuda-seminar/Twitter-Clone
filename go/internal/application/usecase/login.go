package usecase

import (
	"x-clone-backend/internal/domain/entity"
)

type LoginUsecase interface {
	Login(username, password string) (entity.User, string, error)
}
