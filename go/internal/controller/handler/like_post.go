package handler

import (
	"encoding/json"
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
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/776
	// - Update OpenAPI Schema to Support More Conditions for LikePost.
	if err != nil {
		http.Error(w, ErrDecodeRequestBody.Error(), http.StatusBadRequest)
		return
	}

	err = h.likePostUsecase.LikePost(userID, body.PostId)
	if err != nil {
		http.Error(w, ErrCreateLike.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
