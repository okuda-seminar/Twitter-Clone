package api

type LikePostUsecase interface {
	LikePost(userID string, postID string) error

	SetError(err error)
	ClearError()
}
