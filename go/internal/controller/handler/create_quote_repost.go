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

type CreateQuoteRepostHandler struct {
	db                        *sql.DB
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewCreateQuoteRepostHandler(db *sql.DB, updateNotificationUsecase usecase.UpdateNotificationUsecase) CreateQuoteRepostHandler {
	return CreateQuoteRepostHandler{
		db:                        db,
		updateNotificationUsecase: updateNotificationUsecase,
	}
}

// CreateQuoteRepost creates a new quote repost with the specified post_id and user_id,
// then, inserts it into reposts table.
func (h *CreateQuoteRepostHandler) CreateQuoteRepost(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.CreateQuoteRepostRequest

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

	postType := entity.PostTypeQuoteRepost

	err = h.db.QueryRow(query, postType, userID, body.PostId, body.Text).Scan(&id, &createdAt)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a quote repost."), http.StatusInternalServerError)
		return
	}

	quoteRepost := entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: body.PostId, Valid: true},
		Text:         body.Text,
		CreatedAt:    createdAt,
	}

	go h.updateNotificationUsecase.SendNotification(userID, entity.QuoteRepostCreated, &quoteRepost)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(&quoteRepost)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
