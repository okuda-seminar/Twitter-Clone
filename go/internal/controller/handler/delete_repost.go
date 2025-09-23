package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/openapi"
)

type DeleteRepostHandler struct {
	deleteRepostUsecase usecase.DeleteRepostUsecase
}

func NewDeleteRepostHandler(deleteRepostUsecase usecase.DeleteRepostUsecase) DeleteRepostHandler {
	return DeleteRepostHandler{
		deleteRepostUsecase,
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

	err = h.deleteRepostUsecase.DeleteRepost(body.RepostId)
	if err != nil {
		http.Error(w, ErrDeleteRepostFailed.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
