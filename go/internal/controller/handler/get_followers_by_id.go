package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
)

type GetFollowersByIDHandler struct {
	getFollowersByIDUsecase usecase.GetFollowersByIDUsecase
}

func NewGetFollowersByIDHandler(getFollowersByIDUsecase usecase.GetFollowersByIDUsecase) GetFollowersByIDHandler {
	return GetFollowersByIDHandler{
		getFollowersByIDUsecase,
	}
}

// GetFollowersByID gets all users who follow the specified user.
func (h *GetFollowersByIDHandler) GetFollowersByID(w http.ResponseWriter, r *http.Request, userID string) {
	followers, err := h.getFollowersByIDUsecase.GetFollowersByID(userID)
	if err != nil {
		switch err.Error() {
		case usecase.ErrUserNotFound.Error():
			http.Error(w, ErrUserNotFound.Error(), http.StatusNotFound)
			return
		default:
			http.Error(w, ErrGetFollowersByIDFailed.Error(), http.StatusInternalServerError)
			return
		}
	}

	res := transfer.ToGetFollowersByIDResponse(followers)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
