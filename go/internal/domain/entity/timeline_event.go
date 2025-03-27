package entity

const (
	TimelineAccessed   = "TimelineAccessed"
	PostCreated        = "PostCreated"
	PostDeleted        = "PostDeleted"
	RepostCreated      = "RepostCreated"
	RepostDeleted      = "RepostDeleted"
	QuoteRepostCreated = "QuoteRepostCreated"
)

type TimelineEvent struct {
	EventType     string          `json:"event_type"`
	Posts         []*Post         `json:"posts"`
	Reposts       []*Repost       `json:"reposts"`
	TimelineItems []*TimelineItem `json:"timeline_items"`
}
