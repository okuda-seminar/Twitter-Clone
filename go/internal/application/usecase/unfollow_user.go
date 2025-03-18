package usecase

type UnfollowUserUsecase interface {
	UnfollowUser(sourceUserID, targetUserID string) error
}
