package usecase

type BlockUserUsecase interface {
	BlockUser(sourceUserID, targetUserID string) error
}
