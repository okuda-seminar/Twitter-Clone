package api

type UnfollowUserUsecase interface {
	UnfollowUser(sourceUserID, targetUserID string) error
}
