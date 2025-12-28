package messaging

import "encoding/json"

type TimelineEvent struct {
	Type    string          `json:"type"`
	Payload json.RawMessage `json:"payload"`
}

const (
	TypeDeletePost   = "deletePost"
	TypeDeleteRepost = "deleteRepost"
)
