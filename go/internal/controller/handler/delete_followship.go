package handler

import (
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
)

// DeleteFollowshipHandler handles the DELETE /api/users/{sourceUserID}/following/{targetUserID}
type DeleteFollowshipHandler struct {
	unfollowUserUsecase usecase.UnfollowUserUsecase
}

// NewDeleteFollowshipHandler initializes the handler with its dependencies
func NewDeleteFollowshipHandler(unfollowUserUsecase usecase.UnfollowUserUsecase) DeleteFollowshipHandler {
	return DeleteFollowshipHandler{
		unfollowUserUsecase,
	}
}

// DeleteFollowship removes a followship between sourceUserID and targetUserID.
// endpoint: DELETE /api/users/{sourceUserID}/following/{targetUserID}
// Successful: returns status code 204
func (h *DeleteFollowshipHandler) DeleteFollowship(
	w http.ResponseWriter,
	r *http.Request,
	sourceUserID string,
	targetUserID string,
) {
	err := h.unfollowUserUsecase.UnfollowUser(sourceUserID, targetUserID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrFollowshipNotFound):
			http.Error(w, ErrFollowshipNotFound.Error(), http.StatusNotFound)
		default:
			http.Error(w, ErrDeleteFollowship.Error(), http.StatusInternalServerError)
		}
		return
	}
	w.WriteHeader(http.StatusNoContent)
}
