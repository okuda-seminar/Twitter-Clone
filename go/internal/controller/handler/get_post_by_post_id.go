package handler

import (
	"encoding/json"
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
)

type GetPostByPostIDHandler struct {
	getPostByPostIDUsecase usecase.GetPostByPostIDUsecase
}

func NewGetPostByPostIDHandler(getPostByPostIDUsecase usecase.GetPostByPostIDUsecase) GetPostByPostIDHandler {
	return GetPostByPostIDHandler{
		getPostByPostIDUsecase: getPostByPostIDUsecase,
	}
}

// GetPostByPostID gets a post with the specified ID.
// If the retrieval post is repost or quote repost, response includes the parent post of it.
func (h *GetPostByPostIDHandler) GetPostByPostID(w http.ResponseWriter, r *http.Request, postID string) {
	timelineItem, parentTimelineItem, err := h.getPostByPostIDUsecase.GetPostAndParentPostByPostID(postID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrTimelineItemNotFound):
			http.Error(w, ErrTimelineItemNotFound.Error(), http.StatusNotFound)
			return
		default:
			http.Error(w, ErrGetPostByPostID.Error(), http.StatusInternalServerError)
			return
		}
	}

	res, err := transfer.ToGetPostByPostIdResponse(timelineItem, parentTimelineItem)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
