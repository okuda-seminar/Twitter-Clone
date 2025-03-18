package usecase

type UnlikePostUsecase interface {
	UnlikePost(userID string, postID string) error
}
