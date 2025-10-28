package handler

import (
	"encoding/json"
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
)

type GetUserByUserIDHandler struct {
	userByUserIDUsecase usecase.UserByUserIDUsecase
}

func NewGetUserByUserIDHandler(userByUserIDUsecase usecase.UserByUserIDUsecase) GetUserByUserIDHandler {
	return GetUserByUserIDHandler{
		userByUserIDUsecase,
	}
}

// GetUserByUserID gets a user with the specified ID.
func (h *GetUserByUserIDHandler) GetUserByUserID(w http.ResponseWriter, r *http.Request, userID string) {

	userProfile, err := h.userByUserIDUsecase.UserByUserID(userID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrUserNotFound):
			http.Error(w, ErrUserNotFound.Error(), http.StatusNotFound)
			return
		default:
			http.Error(w, ErrGetUserByUserID.Error(), http.StatusInternalServerError)
			return
		}
	}
	res := transfer.ToGetUserByUserIDResponse(userProfile)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
