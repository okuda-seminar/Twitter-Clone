package entities

import "github.com/google/uuid"

// Repost represents an entry of `reposts` table.
// It contains properties such as UserID and PostID.
// UserID is the ID of a user who reposts a post.
type Repost struct {
	PostID uuid.UUID `json:"post_id"`
	UserID uuid.UUID `json:"user_id"`
}
