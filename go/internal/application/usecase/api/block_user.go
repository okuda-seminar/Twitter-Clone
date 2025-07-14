package api

type BlockUserUsecase interface {
	BlockUser(sourceUserID, targetUserID string) error

	SetError(err error)
	ClearError()
}
