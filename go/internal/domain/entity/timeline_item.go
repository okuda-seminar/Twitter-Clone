package entity

import (
	"time"

	"x-clone-backend/internal/domain/value"
)

const (
	PostTypePost        = "post"
	PostTypeRepost      = "repost"
	PostTypeQuoteRepost = "quoteRepost"
)

const (
	PostTextMaxLength = 140
)

// TimelineItem represents an entry of `timelineitems` table.
// It contains properties such as Type, ID, AuthorID, ParentPostID, Text, and CreatedAt.
// AuthorID is the ID of the author of the timeline item.
type TimelineItem struct {
	Type         string         `json:"type"`
	ID           string         `json:"id"`
	AuthorID     string         `json:"authorId"`
	ParentPostID value.NullUUID `json:"parentPostId,omitzero"`
	Text         string         `json:"text,omitzero"`
	CreatedAt    time.Time      `json:"createdAt"`
}
