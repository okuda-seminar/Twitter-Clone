package entities

const (
	TimelineAccessed = "TimelineAccessed"
	PostCreated      = "PostCreated"
	PostDeleted      = "PostDeleted"
	RepostCreated    = "RepostCreated"
	RepostDeleted    = "RepostDeleted"
)

type TimelineEvent struct {
	EventType string  `json:"event_type"`
	Posts     []*Post `json:"posts"`
}
