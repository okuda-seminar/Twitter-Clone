package api

import (
	"x-clone-backend/internal/domain/entity"
)

type GetFolloweesByIDUsecase interface {
	GetFolloweesByID(userID string) ([]entity.User, error)

	SetFollowees(followees []entity.User)
	SetError(err error)
	ClearError()
}
