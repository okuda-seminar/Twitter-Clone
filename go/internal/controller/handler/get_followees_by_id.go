package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
)

type GetFolloweesByIDHandler struct {
	getFolloweesByIDUsecase usecase.GetFolloweesByIDUsecase
}

func NewGetFolloweesByIDHandler(getFolloweesByIDUsecase usecase.GetFolloweesByIDUsecase) GetFolloweesByIDHandler {
	return GetFolloweesByIDHandler{
		getFolloweesByIDUsecase,
	}
}

// GetFolloweesByID gets all users that the specified user follows.
func (h *GetFolloweesByIDHandler) GetFolloweesByID(w http.ResponseWriter, r *http.Request, userID string) {
	followees, err := h.getFolloweesByIDUsecase.GetFolloweesByID(userID)
	if err != nil {
		switch err.Error() {
		case usecase.ErrUserNotFound.Error():
			http.Error(w, ErrUserNotFound.Error(), http.StatusNotFound)
			return
		default:
			http.Error(w, ErrGetFolloweesByIDFailed.Error(), http.StatusInternalServerError)
			return
		}
	}

	res := transfer.ToGetFolloweesByIDResponse(followees)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
