package handler

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
