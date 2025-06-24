package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

type DeleteRepostHandler struct {
	deleteRepostUsecase       usecase.DeleteRepostUsecase
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewDeleteRepostHandler(deleteRepostUsecase usecase.DeleteRepostUsecase, updateNotificationUsecase usecase.UpdateNotificationUsecase) DeleteRepostHandler {
	return DeleteRepostHandler{
		deleteRepostUsecase,
		updateNotificationUsecase,
	}
}

// DeleteRepost deletes a repost with the specified post ID.
// If the post doesn't exist, it returns 404 error.
func (h *DeleteRepostHandler) DeleteRepost(w http.ResponseWriter, r *http.Request, userID, parentID string) {
	var body openapi.DeleteRepostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, ErrInvalidRequestBody.Error(), http.StatusBadRequest)
		return
	}

	repost, err := h.deleteRepostUsecase.DeleteRepost(body.RepostId)
	if err != nil {
		http.Error(w, ErrDeleteRepostFailed.Error(), http.StatusInternalServerError)
		return
	}

	go h.updateNotificationUsecase.SendNotification(userID, entity.RepostDeleted, &repost)

	w.WriteHeader(http.StatusNoContent)
}
