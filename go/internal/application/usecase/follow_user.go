package usecase

type FollowUserUsecase interface {
	FollowUser(sourceUserID, targetUserID string) error
}
