package handlers

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

// createRepostRequestBody is the type of the "CreateRepost"
// endpoint request body.
type createRepostRequestBody struct {
	PostID uuid.UUID `json:"post_id,omitempty"`
	UserID uuid.UUID `json:"user_id,omitempty"`
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
