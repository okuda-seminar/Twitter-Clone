package api

import (
	"x-clone-backend/internal/domain/entity"
)

type UserByUserIDUsecase interface {
	UserByUserID(userID string) (entity.User, error)

	SetError(err error)
	ClearError()
	SetUser(entity.User)
}
