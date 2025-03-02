// Package openapi provides primitives to interact with the openapi HTTP API.
//
// Code generated by github.com/oapi-codegen/oapi-codegen/v2 version v2.4.1 DO NOT EDIT.
package openapi

import (
	"time"
)

// CreatePostRequest defines model for create_post_request.
type CreatePostRequest struct {
	Text   string `json:"text"`
	UserId string `json:"user_id"`
}

// CreatePostResponse defines model for create_post_response.
type CreatePostResponse struct {
	CreatedAt time.Time `json:"created_at"`
	Id        string    `json:"id"`
	Text      string    `json:"text"`
	UserId    string    `json:"user_id"`
}

// CreateRepostRequest defines model for create_repost_request.
type CreateRepostRequest struct {
	PostId string `json:"post_id"`
	UserId string `json:"user_id"`
}

// CreateUserRequest defines model for create_user_request.
type CreateUserRequest struct {
	DisplayName string `json:"display_name"`

	// Password Password must be between 8 and 15 characters.
	Password string `json:"password"`
	Username string `json:"username"`
}

// CreateUserResponse defines model for create_user_response.
type CreateUserResponse struct {
	Token string `json:"token"`
	User  struct {
		Bio         string    `json:"bio"`
		CreatedAt   time.Time `json:"created_at"`
		DisplayName string    `json:"display_name"`
		Id          string    `json:"id"`
		IsPrivate   bool      `json:"is_private"`
		UpdatedAt   time.Time `json:"updated_at"`
		Username    string    `json:"username"`
	} `json:"user"`
}

// FindUserByIdResponse defines model for find_user_by_id_response.
type FindUserByIdResponse struct {
	Bio         string    `json:"bio"`
	CreatedAt   time.Time `json:"created_at"`
	DisplayName string    `json:"display_name"`
	Id          string    `json:"id"`
	IsPrivate   bool      `json:"is_private"`
	UpdatedAt   time.Time `json:"updated_at"`
	Username    string    `json:"username"`
}

// GetReverseChronologicalHomeTimelineResponse defines model for get_reverse_chronological_home_timeline_response.
type GetReverseChronologicalHomeTimelineResponse struct {
	Data *struct {
		EventType string `json:"event_type"`
		Posts     struct {
			CreatedAt time.Time `json:"created_at"`
			Id        string    `json:"id"`
			Text      string    `json:"text"`
			UserId    string    `json:"user_id"`
		} `json:"posts"`
	} `json:"data,omitempty"`
}

// GetUserPostsTimelineResponse defines model for get_user_posts_timeline_response.
type GetUserPostsTimelineResponse = []struct {
	CreatedAt time.Time `json:"created_at"`
	Id        string    `json:"id"`
	Text      string    `json:"text"`
	UserId    string    `json:"user_id"`
}

// LoginRequest defines model for login_request.
type LoginRequest struct {
	Password string `json:"password"`
	Username string `json:"username"`
}

// LoginResponse defines model for login_response.
type LoginResponse struct {
	Token string `json:"token"`
	User  struct {
		Bio         string    `json:"bio"`
		CreatedAt   time.Time `json:"created_at"`
		DisplayName string    `json:"display_name"`
		Id          string    `json:"id"`
		IsPrivate   bool      `json:"is_private"`
		UpdatedAt   time.Time `json:"updated_at"`
		Username    string    `json:"username"`
	} `json:"user"`
}

// LoginJSONRequestBody defines body for Login for application/json ContentType.
type LoginJSONRequestBody = LoginRequest

// CreatePostJSONRequestBody defines body for CreatePost for application/json ContentType.
type CreatePostJSONRequestBody = CreatePostRequest

// CreateRepostJSONRequestBody defines body for CreateRepost for application/json ContentType.
type CreateRepostJSONRequestBody = CreateRepostRequest

// CreateUserJSONRequestBody defines body for CreateUser for application/json ContentType.
type CreateUserJSONRequestBody = CreateUserRequest
