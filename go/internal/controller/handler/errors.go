package handler

import (
	"errors"
	"fmt"
)

var (
	ErrDecodeRequestBody  = errors.New("Request body was invalid.")
	ErrEncodeResponse     = errors.New("Could not encode response.")
	ErrTooLongText        = errors.New("Text is too long.")
	ErrUserNotFound       = errors.New("User not found.")
	ErrCreatePost         = errors.New("Could not create a post.")
	ErrInvalidRequestBody = errors.New("Request body was invalid.")
	ErrCreateFollowship   = errors.New("Could not create followship.")
	ErrFollowshipNotFound = errors.New("No row found to delete")
	ErrDeleteFollowship   = errors.New("Could not delete followship.")
)

func NewInvalidUserIDError(id string) error {
	return fmt.Errorf("Could not parse a userID (ID: %s).", id)
}
