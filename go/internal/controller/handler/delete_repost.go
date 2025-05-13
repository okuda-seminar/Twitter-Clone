package handler

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"time"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/value"
	"x-clone-backend/internal/openapi"
)

type DeleteRepostHandler struct {
	db                        *sql.DB
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewDeleteRepostHandler(db *sql.DB, updateNotificationUsecase usecase.UpdateNotificationUsecase) DeleteRepostHandler {
	return DeleteRepostHandler{
		db:                        db,
		updateNotificationUsecase: updateNotificationUsecase,
	}
}

// DeleteRepost deletes a repost with the specified post ID.
// If the post doesn't exist, it returns 404 error.
func (h *DeleteRepostHandler) DeleteRepost(w http.ResponseWriter, r *http.Request, userID, parentID string) {
	var body openapi.DeleteRepostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	query := `DELETE FROM timelineitems WHERE id = $1 RETURNING type, text, created_at`

	var (
		postType  string
		text      string
		createdAt time.Time
	)

	err = h.db.QueryRow(query, body.RepostId).Scan(&postType, &text, &createdAt)
	if err != nil {
		switch {
		case errors.Is(err, sql.ErrNoRows):
			http.Error(w, fmt.Sprintf("No row found to delete: (repost id: %s)\n", body.RepostId), http.StatusNotFound)
		default:
			http.Error(w, fmt.Sprintf("Could not delete a repost: (repost id: %s)\n", body.RepostId), http.StatusInternalServerError)
		}
		return
	}

	timelineitem := entity.TimelineItem{
		Type:         postType,
		ID:           body.RepostId,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: parentID, Valid: true},
		Text:         text,
		CreatedAt:    createdAt,
	}

	go h.updateNotificationUsecase.SendNotification(userID, entity.RepostDeleted, &timelineitem)

	w.WriteHeader(http.StatusNoContent)
}
