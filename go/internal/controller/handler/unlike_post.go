package handler

import (
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
)

type UnlikePostHandler struct {
	unlikePostUsecase usecase.UnlikePostUsecase
}

func NewUnlikePostHandler(unlikePostUsecase usecase.UnlikePostUsecase) UnlikePostHandler {
	return UnlikePostHandler{
		unlikePostUsecase,
	}
}

func (h *UnlikePostHandler) UnlikePost(w http.ResponseWriter, r *http.Request, userID, postID string) {
	err := h.unlikePostUsecase.UnlikePost(userID, postID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrLikeNotFound):
			http.Error(w, ErrLikeNotFound.Error(), http.StatusNotFound)
		default:
			http.Error(w, ErrDeleteLike.Error(), http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
