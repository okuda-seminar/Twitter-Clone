package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/openapi"
)

// DeleteUserByIDHandler handles the DELETE /api/users/{userId} request.
type DeleteUserByIDHandler struct {
	deleteUserByIDUsecase usecase.DeleteUserByIDUsecase
}

// NewDeleteUserByIDHandler initializes the handler with its dependencies.
func NewDeleteUserByIDHandler(deleteUserByIDUsecase usecase.DeleteUserByIDUsecase) DeleteUserByIDHandler {
	return DeleteUserByIDHandler{
		deleteUserByIDUsecase,
	}
}

// DeleteUserByID deletes a user with the specified user ID.
// endpoint: DELETE /api/users/{userId}
// Successful: returns status code 204
func (h *DeleteUserByIDHandler) DeleteUserByID(
	w http.ResponseWriter,
	r *http.Request,
	userID string,
) {
	if err := h.deleteUserByIDUsecase.DeleteUserByID(userID); err != nil {
		var (
			status int
			body   openapi.DeleteUserByIdResponse
		)
		switch err.Error() {
		case usecase.ErrUserNotFound.Error():
			status = http.StatusNotFound
			body.Message = ErrUserNotFound.Error()
		default:
			status = http.StatusInternalServerError
			body.Message = ErrDeleteUserFailed.Error()
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(status)
		_ = json.NewEncoder(w).Encode(body)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
