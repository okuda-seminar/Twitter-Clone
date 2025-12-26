package messaging

type TimelineEvent struct {
	Type    string `json:"type"`
	Payload any    `json:"payload"`
}

const (
	TypeDeletePost   = "deletePost"
	TypeDeleteRepost = "deleteRepost"
)
