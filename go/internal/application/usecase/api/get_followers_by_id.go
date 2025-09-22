package api

import (
	"x-clone-backend/internal/domain/entity"
)

type GetFollowersByIDUsecase interface {
	GetFollowersByID(userID string) ([]entity.User, error)

	SetFollowers(followers []entity.User)
	SetError(err error)
	ClearError()
}
