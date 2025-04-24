package handler

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/google/uuid"

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
func (h *DeleteRepostHandler) DeleteRepost(w http.ResponseWriter, r *http.Request, userIDStr string, parentIDStr string) {
	var body openapi.DeleteRepostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	RepostID, err := uuid.Parse(body.RepostId)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not parse a RepostId (ID: %s)\n", body.RepostId), http.StatusBadRequest)
		return
	}

	query := `DELETE FROM timelineitems WHERE id = $1 RETURNING type, text, created_at`

	var (
		postType  string
		text      string
		createdAt time.Time
	)

	err = h.db.QueryRow(query, RepostID).Scan(&postType, &text, &createdAt)
	if err != nil {
		switch {
		case errors.Is(err, sql.ErrNoRows):
			http.Error(w, fmt.Sprintf("No row found to delete: (repost id: %s)\n", RepostID), http.StatusNotFound)
		default:
			http.Error(w, fmt.Sprintf("Could not delete a repost: (repost id: %s)\n", RepostID), http.StatusInternalServerError)
		}
		return
	}

	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not parse a userID (ID: %s)\n", userIDStr), http.StatusBadRequest)
		return
	}

	parentID, err := uuid.Parse(parentIDStr)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not parse a parentID (ID: %s)\n", parentIDStr), http.StatusBadRequest)
		return
	}

	timelineitem := entity.TimelineItem{
		Type:         postType,
		ID:           RepostID,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: parentID, Valid: true},
		Text:         text,
		CreatedAt:    createdAt,
	}

	go h.updateNotificationUsecase.SendNotification(userIDStr, entity.RepostDeleted, &timelineitem)

	w.WriteHeader(http.StatusNoContent)
}
