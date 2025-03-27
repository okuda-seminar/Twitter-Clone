package entity

import (
	"time"

	"x-clone-backend/internal/domain/value"

	"github.com/google/uuid"
)

const (
	PostTypePost        = "post"
	PostTypeRepost      = "repost"
	PostTypeQuoteRepost = "quoteRepost"
)

// TimelineItem represents an entry of `timelineitems` table.
// It contains properties such as Type, ID, AuthorID, ParentPostID, Text, and CreatedAt.
// AuthorID is the ID of the author of the timeline item.
type TimelineItem struct {
	Type         string         `json:"type"`
	ID           uuid.UUID      `json:"id"`
	AuthorID     uuid.UUID      `json:"authorId"`
	ParentPostID value.NullUUID `json:"parentPostId,omitzero"`
	Text         string         `json:"text,omitzero"`
	CreatedAt    time.Time      `json:"createdAt"`
}
