package entities

import (
	"time"

	"github.com/google/uuid"
)

// Repost represents an entry of `reposts` table.
// It contains properties such as UserID and PostID.
// UserID is the ID of a user who reposts a post.
type Repost struct {
	ID        uuid.UUID `json:"id"`
	ParentID  uuid.UUID `json:"parent_id"`
	UserID    uuid.UUID `json:"user_id"`
	Text      string    `json:"text"`
	CreatedAt time.Time `json:"created_at"`
}
