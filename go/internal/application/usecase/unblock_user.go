package usecase

type UnblockUserUsecase interface {
	UnblockUser(sourceUserID, targetUserID string) error
}
