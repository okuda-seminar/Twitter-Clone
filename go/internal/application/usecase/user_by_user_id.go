package usecase

import (
	"x-clone-backend/internal/domain/entity"
)

type UserByUserIDUsecase interface {
	UserByUserID(userID string) (entity.User, error)
}
