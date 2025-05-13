package handler

import (
	"encoding/json"
	"errors"
	"net/http"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/controller/transfer"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

type CreatePostHandler struct {
	updateNotificationUsecase usecase.UpdateNotificationUsecase
	createPostUsecase         usecase.CreatePostUsecase
}

func NewCreatePostHandler(updateNotificationUsecase usecase.UpdateNotificationUsecase, createPostUsecase usecase.CreatePostUsecase) CreatePostHandler {
	return CreatePostHandler{
		updateNotificationUsecase,
		createPostUsecase,
	}
}

// CreatePost creates a new post with the specified user_id and text,
// then, inserts it into posts table.
func (h *CreatePostHandler) CreatePost(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.CreatePostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, ErrDecodeRequestBody.Error(), http.StatusBadRequest)
		return
	}

	post, err := h.createPostUsecase.CreatePost(userID, body.Text)
	if err != nil {
		if errors.Is(err, usecase.ErrUserNotFound) {
			http.Error(w, ErrUserNotFound.Error(), http.StatusBadRequest)
			return
		} else if errors.Is(err, usecase.ErrTooLongText) {
			http.Error(w, ErrTooLongText.Error(), http.StatusBadRequest)
			return
		}

		http.Error(w, ErrCreatePost.Error(), http.StatusInternalServerError)
		return
	}

	go h.updateNotificationUsecase.SendNotification(userID, entity.PostCreated, &post)

	res := transfer.ToCreatePostResponse(&post)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
