package api

type DeletePostUsecase interface {
	DeletePost(postID string) error

	SetError(err error)
	ClearError()
}
