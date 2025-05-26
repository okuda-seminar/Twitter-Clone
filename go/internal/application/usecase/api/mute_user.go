package api

type MuteUserUsecase interface {
	MuteUser(sourceUserID, targetUserID string) error
}
