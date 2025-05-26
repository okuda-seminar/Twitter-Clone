package api

type UnblockUserUsecase interface {
	UnblockUser(sourceUserID, targetUserID string) error
}
