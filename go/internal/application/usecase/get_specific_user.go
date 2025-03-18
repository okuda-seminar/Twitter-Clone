package usecase

import (
	"x-clone-backend/internal/domain/entity"
)

type GetSpecificUserUsecase interface {
	GetSpecificUser(userID string) (entity.User, error)
}
