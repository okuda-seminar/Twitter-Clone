package api

type DeleteRepostUsecase interface {
	DeleteRepost(repostID string) error

	SetError(err error)
	ClearError()
}
