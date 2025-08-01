package api

type UnmuteUserUsecase interface {
	UnmuteUser(sourceUserID, targetUserID string) error

	SetError(err error)
	ClearError()
}
