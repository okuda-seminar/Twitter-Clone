package api

type UnlikePostUsecase interface {
	UnlikePost(userID string, postID string) error
	SetError(err error)
	ClearError()
}
