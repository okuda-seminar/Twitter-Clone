package handler

import (
	"encoding/json"
	"fmt"
	"log/slog"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
)

type FindUserByIDHandler struct {
	userByUserIDUsecase usecase.UserByUserIDUsecase
}

func NewFindUserByIDHandler(userByUserIDUsecase usecase.UserByUserIDUsecase) FindUserByIDHandler {
	return FindUserByIDHandler{
		userByUserIDUsecase,
	}
}

// FindUserByID finds a user with the specified ID.
func (h *FindUserByIDHandler) FindUserByID(w http.ResponseWriter, r *http.Request, userID string) {
	slog.Info("GET /api/users/{userID} was called.")

	user, err := h.userByUserIDUsecase.UserByUserID(userID)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not find a user (ID: %s)\n", userID), http.StatusNotFound)
		return
	}
	res := transfer.ToFindUserByIDResponse(&user)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
