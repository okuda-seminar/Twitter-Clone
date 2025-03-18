package value

import "x-clone-backend/internal/domain/entity"

const (
	TimelineAccessed   = "TimelineAccessed"
	PostCreated        = "PostCreated"
	PostDeleted        = "PostDeleted"
	RepostCreated      = "RepostCreated"
	RepostDeleted      = "RepostDeleted"
	QuoteRepostCreated = "QuoteRepostCreated"
)

type TimelineEvent struct {
	EventType string           `json:"event_type"`
	Posts     []*entity.Post   `json:"posts"`
	Reposts   []*entity.Repost `json:"reposts"`
}
