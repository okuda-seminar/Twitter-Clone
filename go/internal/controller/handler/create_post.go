package handler

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/google/uuid"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/value"
)

type CreatePostHandler struct {
	db                        *sql.DB
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewCreatePostHandler(db *sql.DB, updateNotificationUsecase usecase.UpdateNotificationUsecase) CreatePostHandler {
	return CreatePostHandler{
		db:                        db,
		updateNotificationUsecase: updateNotificationUsecase,
	}
}

// CreatePost creates a new post with the specified user_id and text,
// then, inserts it into posts table.
//
// TODO: https://github.com/okuda-seminar/X-Clone-Backend/issues/174
// - [Posts] Separate the logic of CreatePost into usecase and repository layers.
func (h *CreatePostHandler) CreatePost(w http.ResponseWriter, r *http.Request) {
	var body createPostRequestBody

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	query := `INSERT INTO timelineitems (type, author_id, text) VALUES ($1, $2, $3) RETURNING id, created_at`

	var (
		id        uuid.UUID
		createdAt time.Time
	)

	postType := entity.PostTypePost

	err = h.db.QueryRow(query, postType, body.UserID, body.Text).Scan(&id, &createdAt)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a post."), http.StatusInternalServerError)
		return
	}

	post := entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     body.UserID,
		ParentPostID: value.NullUUID{},
		Text:         body.Text,
		CreatedAt:    createdAt,
	}

	go h.updateNotificationUsecase.SendNotification(body.UserID.String(), entity.PostCreated, &post)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(&post)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
