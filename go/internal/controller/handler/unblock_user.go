package handler

import (
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
)

type UnblockUserHandler struct {
	unblockUserUsecase usecase.UnblockUserUsecase
}

func NewUnblockUserHandler(unblockUserUsecase usecase.UnblockUserUsecase) UnblockUserHandler {
	return UnblockUserHandler{
		unblockUserUsecase,
	}
}

func (h *UnblockUserHandler) UnblockUser(w http.ResponseWriter, r *http.Request, sourceUserID, targetUserID string) {
	err := h.unblockUserUsecase.UnblockUser(sourceUserID, targetUserID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrBlockNotFound):
			http.Error(w, "No row found to delete", http.StatusNotFound)
		default:
			http.Error(w, "Could not delete blocking.", http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
