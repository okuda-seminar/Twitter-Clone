package handler

import (
	"github.com/google/uuid"
)

// createPostRequestBody is the type of the "CreatePost"
// endpoint request body.
type createPostRequestBody struct {
	UserID uuid.UUID `json:"user_id,omitempty"`
	Text   string    `json:"text"`
}

// likePostRequestBody is the type of the "LikePost"
// endpoint request body.
type likePostRequestBody struct {
	PostID uuid.UUID `json:"post_id,omitempty"`
}

// createFollowshipRequestBody is the type of the "CreateFollowship"
// endpoint request body.
type createFollowshipRequestBody struct {
	TargetUserID string `json:"target_user_id"`
}

// createMutingRequestBody is the type of the "CreateMute"
// endpoint request body.
type createMutingRequestBody struct {
	TargetUserID string `json:"target_user_id,omitempty"`
}

// createBlockingRequestBody is the type of the "CreateBlocking"
// endpoint request body.
type createBlockingRequestBody struct {
	TargetUserID string `json:"target_user_id,omitempty"`
}
