package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
)

type GetUserPostsTimelineHandler struct {
	specificUserPostsUsecase usecase.SpecificUserPostsUsecase
}

func NewGetUserPostsTimelineHandler(specificUserPostsUsecase usecase.SpecificUserPostsUsecase) GetUserPostsTimelineHandler {
	return GetUserPostsTimelineHandler{
		specificUserPostsUsecase,
	}
}

// GetUserPostsTimeline gets posts by a single user, specified by the requested user ID.
func (h *GetUserPostsTimelineHandler) GetUserPostsTimeline(w http.ResponseWriter, r *http.Request, id string) {
	timelineitems, err := h.specificUserPostsUsecase.SpecificUserPosts(id)
	if err != nil {
		http.Error(w, ErrGetTimeLineItemsFailed.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	encoder := json.NewEncoder(w)
	if err := encoder.Encode(timelineitems); err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
