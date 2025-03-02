package errors

import "errors"

var (
	ErrUserNotFound       = errors.New("user not found")
	ErrLikeNotFound       = errors.New("like not found")
	ErrFollowshipNotFound = errors.New("followship not found")
	ErrMuteNotFound       = errors.New("mute not found")
	ErrBlockNotFound      = errors.New("block not found")
	ErrInvalidCredentials = errors.New("invalid username or password")
	ErrTokenGeneration    = errors.New("could not generate token")
)
