package usecase

type LikePostUsecase interface {
	LikePost(userID string, postID string) error
}
