package usecase

type UnmuteUserUsecase interface {
	UnmuteUser(sourceUserID, targetUserID string) error
}
