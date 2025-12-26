package messaging

import (
	"fmt"
)

type DeletePostMessage struct {
	PostID string
}

// Validate checks if the DeletePostMessage fields are valid
func (i DeletePostMessage) Validate() error {
	if i.PostID == "" {
		return fmt.Errorf("postID is required")
	}
	return nil
}

type DeleteRepostMessage struct {
	PostID string
}

// Validate checks if the DeleteRepostMessage fields are valid
func (i DeleteRepostMessage) Validate() error {
	if i.PostID == "" {
		return fmt.Errorf("postID is required")
	}
	return nil
}
