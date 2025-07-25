package handler

import (
	"errors"
	"fmt"
)

var (
	ErrFollowshipNotFound     = errors.New("No row found to delete")
	ErrDeleteFollowship       = errors.New("Could not delete followship.")
	ErrDecodeRequestBody      = errors.New("Request body was invalid.")
	ErrEncodeResponse         = errors.New("Could not encode response.")
	ErrTooLongText            = errors.New("Text is too long.")
	ErrUserNotFound           = errors.New("User not found.")
	ErrCreatePost             = errors.New("Could not create a post.")
	ErrCreateQuoteRepost      = errors.New("Could not create a quote repost.")
	ErrInvalidRequestBody     = errors.New("Request body was invalid.")
	ErrCreateFollowship       = errors.New("Could not create followship.")
	ErrTimelineItemNotFound   = errors.New("Timeline item not found.")
	ErrRepostViolation        = errors.New("Could not repost a repost.")
	ErrCreateRepost           = errors.New("Could not create a repost.")
	ErrDeleteUserFailed       = errors.New("Could not delete a user.")
	ErrDeletePostFailed       = errors.New("Could not delete a post.")
	ErrDeleteRepostFailed     = errors.New("Could not delete a repost.")
	ErrCreateLike             = errors.New("Could not create a like.")
	ErrInvalidToken           = errors.New("Invalid or expired token.")
	ErrInternalError          = errors.New("Unexpected error occurred.")
	ErrGetTimeLineItemsFailed = errors.New("Could not get timeline items.")
	ErrCreateBlock            = errors.New("Could not create a block.")
	ErrSetChannel             = errors.New("Failed to set notification channel")
	ErrUserAndFolloweePosts   = errors.New("Could not get timelineitems")
	ErrCreateMuting           = errors.New("Could not create muting")
)

func NewInvalidUserIDError(id string) error {
	return fmt.Errorf("Could not parse a userID (ID: %s).", id)
}

func NewUserNotFoundError(userID string) error {
	return fmt.Errorf("Could not find a user (ID: %s).", userID)
}
