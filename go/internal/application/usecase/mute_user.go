package usecase

type MuteUserUsecase interface {
	MuteUser(sourceUserID, targetUserID string) error
}
