package api

import "errors"

var (
	ErrFollowshipNotFound = errors.New("followship not found")
	ErrMuteNotFound       = errors.New("mute not found")
	ErrBlockNotFound      = errors.New("block not found")
	ErrLikeNotFound       = errors.New("like not found")
	ErrUserNotFound       = errors.New("user not found")
	ErrUserAlreadyExists  = errors.New("user already exists")
	ErrInvalidCredentials = errors.New("invalid username or password")
	ErrTokenGeneration    = errors.New("could not generate token")
	ErrTooLongText        = errors.New("text is too long")
)
