package handler

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"

	"github.com/google/uuid"
	"log/slog"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/openapi"
)

type DeleteUserHandler struct {
	usecase usecase.DeleteUserUsecase
}

func NewDeleteUserHandler(u usecase.DeleteUserUsecase) DeleteUserHandler {
	return DeleteUserHandler{
		usecase: u,
	}
}

// DeleteUser deletes a user with the specified userID.
// If the user does not exist, it returns 404.
func (h *DeleteUserHandler) DeleteUser(w http.ResponseWriter, r *http.Request, userIDStr string) {
	var body openapi.DeleteUserRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, "Request body was invalid.", http.StatusBadRequest)
		return
	}

	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		http.Error(w, fmt.Sprintf("Invalid userID format: %s", userIDStr), http.StatusBadRequest)
		return
	}

	slog.Info(fmt.Sprintf("DELETE /api/users/%s was called.", userIDStr))

	err = h.usecase.DeleteUser(userID.String())
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrUserNotFound):
			http.Error(w, fmt.Sprintf("User not found (ID: %s)", userIDStr), http.StatusNotFound)
		default:
			http.Error(w, fmt.Sprintf("Could not delete user (ID: %s)", userIDStr), http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
