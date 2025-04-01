package domain

import "errors"

var (
	ErrInvalidCredentials = errors.New("invalid username or password")
	ErrTokenGeneration    = errors.New("could not generate token")
)
