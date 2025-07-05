package handler

import (
	"encoding/json"
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

	user, err := h.userByUserIDUsecase.UserByUserID(userID)
	if err != nil {
		http.Error(w, NewUserNotFoundError(userID).Error(), http.StatusNotFound)
		return
	}
	res := transfer.ToFindUserByIDResponse(&user)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
