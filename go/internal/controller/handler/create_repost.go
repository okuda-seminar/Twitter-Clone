package handler

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/value"
	"x-clone-backend/internal/openapi"
)

type CreateRepostHandler struct {
	db                        *sql.DB
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewCreateRepostHandler(db *sql.DB, updateNotificationUsecase usecase.UpdateNotificationUsecase) CreateRepostHandler {
	return CreateRepostHandler{
		db:                        db,
		updateNotificationUsecase: updateNotificationUsecase,
	}
}

// CreateRepost creates a new repost with the specified post_id and user_id,
// then, inserts it into reposts table.
func (h *CreateRepostHandler) CreateRepost(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.CreateRepostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	query := `INSERT INTO timelineitems (type, author_id, parent_post_id ,text) VALUES ($1, $2, $3, $4) RETURNING id, created_at`

	var (
		id        string
		createdAt time.Time
	)

	postType := entity.PostTypeRepost
	text := ""

	err = h.db.QueryRow(query, postType, userID, body.PostId, text).Scan(&id, &createdAt)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a repost."), http.StatusInternalServerError)
		return
	}

	repost := entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: body.PostId, Valid: true},
		Text:         text,
		CreatedAt:    createdAt,
	}

	go h.updateNotificationUsecase.SendNotification(userID, entity.RepostCreated, &repost)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(&repost)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
