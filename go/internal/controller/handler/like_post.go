package handler

import (
	"encoding/json"
	"fmt"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/openapi"
)

type LikePostHandler struct {
	likePostUsecase usecase.LikePostUsecase
}

func NewLikePostHandler(likePostUsecase usecase.LikePostUsecase) LikePostHandler {
	return LikePostHandler{
		likePostUsecase,
	}
}

func (h *LikePostHandler) LikePost(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.LikePostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	err = h.likePostUsecase.LikePost(userID, body.PostId)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a like."), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}
