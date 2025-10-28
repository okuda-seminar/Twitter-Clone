package api

import (
	"x-clone-backend/internal/domain/entity"
)

type UserByUserIDUsecase interface {
	UserByUserID(userID string) (user entity.UserProfile, err error)

	SetError(err error)
	ClearError()
	SetUser(userProfile entity.UserProfile)
}
