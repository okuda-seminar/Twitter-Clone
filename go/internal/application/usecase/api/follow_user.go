package api

type FollowUserUsecase interface {
	FollowUser(sourceUserID, targetUserID string) error
}
