package handler

import (
	"errors"
)

var (
	ErrInvalidRequestBody = errors.New("Request body was invalid.")
	ErrCreateFollowship   = errors.New("Could not create followship.")
)
