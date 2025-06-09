package handler

import (
	"database/sql"
	"errors"
	"fmt"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type DeletePostHandler struct {
	db                        *sql.DB
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewDeletePostHandler(db *sql.DB, updateNotificationUsecase usecase.UpdateNotificationUsecase) DeletePostHandler {
	return DeletePostHandler{
		db,
		updateNotificationUsecase,
	}
}

// DeletePost deletes a post with the specified post ID.
// If the post doesn't exist, it returns 404 error.
func (h *DeletePostHandler) DeletePost(w http.ResponseWriter, r *http.Request, postID string) {
	query := `DELETE FROM timelineitems WHERE id = $1 RETURNING type, author_id, text, created_at`
	var post entity.TimelineItem

	err := h.db.QueryRow(query, postID).Scan(&post.Type, &post.AuthorID, &post.Text, &post.CreatedAt)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			http.Error(w, fmt.Sprintf("No row found to delete (ID: %s)\n", postID), http.StatusNotFound)
			return
		}

		http.Error(w, fmt.Sprintf("Could not delete a post (ID: %s)\n", postID), http.StatusInternalServerError)
		return
	}

	post.ID = postID

	go h.updateNotificationUsecase.SendNotification(post.AuthorID, entity.PostDeleted, &post)

	w.WriteHeader(http.StatusNoContent)
}
