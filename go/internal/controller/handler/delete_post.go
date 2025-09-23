package handler

import (
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
)

type DeletePostHandler struct {
	deletePostUsecase usecase.DeletePostUsecase
}

func NewDeletePostHandler(deletePostUsecase usecase.DeletePostUsecase) DeletePostHandler {
	return DeletePostHandler{
		deletePostUsecase,
	}
}

// DeletePost deletes a post with the specified post ID.
// If the post doesn't exist, it returns 404 error.
func (h *DeletePostHandler) DeletePost(w http.ResponseWriter, r *http.Request, postID string) {
	err := h.deletePostUsecase.DeletePost(postID)
	if err != nil {
		http.Error(w, ErrDeletePostFailed.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
