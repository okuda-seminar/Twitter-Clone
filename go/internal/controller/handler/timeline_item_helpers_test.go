package handler

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http/httptest"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func newCreatePost(updateNotificationUsecase usecase.UpdateNotificationUsecase, createPostUsecase usecase.CreatePostUsecase) (string, error) {
	userID := uuid.NewString()
	text := "test"

	createPostHandler := NewCreatePostHandler(updateNotificationUsecase, createPostUsecase)
	body, err := json.Marshal(openapi.CreatePostRequest{
		Text: text,
	})
	if err != nil {
		return "", err
	}

	req := httptest.NewRequest(
		"POST",
		fmt.Sprintf("/api/%s/posts", userID),
		bytes.NewReader(body),
	)
	rr := httptest.NewRecorder()
	createPostHandler.CreatePost(rr, req, userID)

	var post entity.TimelineItem
	_ = json.NewDecoder(rr.Body).Decode(&post)
	postID := post.ID
	return postID, nil
}

func newCreateQuoteRepost(updateNotificationUsecase usecase.UpdateNotificationUsecase, createQuoteRepostusecase usecase.CreateQuoteRepostUsecase, parentPostID string) (string, error) {
	userID := uuid.NewString()
	text := "test"

	CreateQuoteRepostHandler := NewCreateQuoteRepostHandler(createQuoteRepostusecase, updateNotificationUsecase)

	body, err := json.Marshal(openapi.CreateQuoteRepostRequest{
		PostId: parentPostID,
		Text:   text,
	})
	if err != nil {
		return "", err
	}

	req := httptest.NewRequest(
		"POST",
		fmt.Sprintf("/api/%s/quote_reposts", userID),
		bytes.NewReader(body),
	)
	rr := httptest.NewRecorder()
	CreateQuoteRepostHandler.CreateQuoteRepost(rr, req, userID)

	var post entity.TimelineItem
	_ = json.NewDecoder(rr.Body).Decode(&post)
	postID := post.ID
	return postID, nil
}
