package api

type DeleteUserByIDUsecase interface {
	DeleteUserByID(userID string) error

	SetError(err error)
	ClearError()
}
