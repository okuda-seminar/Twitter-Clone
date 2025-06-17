package handler

import (
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
)

type UnmuteUserHandler struct {
	unmuteUserUsecase usecase.UnmuteUserUsecase
}

func NewUnmuteUserHandler(unmuteUserUsecase usecase.UnmuteUserUsecase) UnmuteUserHandler {
	return UnmuteUserHandler{
		unmuteUserUsecase,
	}
}

func (h *UnmuteUserHandler) UnmuteUser(w http.ResponseWriter, r *http.Request, sourceUserID, targetUserID string) {
	err := h.unmuteUserUsecase.UnmuteUser(sourceUserID, targetUserID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrMuteNotFound):
			http.Error(w, "No row found to delete", http.StatusNotFound)
		default:
			http.Error(w, "Could not delete mute.", http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
