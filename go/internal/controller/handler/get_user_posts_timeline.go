package handler

import (
	"encoding/json"
	"net/http"

	"x-clone-backend/internal/application/usecase"
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
		http.Error(w, "Failed to get timelineitems", http.StatusInternalServerError)
	}

	w.Header().Set("Content-Type", "application/json")
	encoder := json.NewEncoder(w)
	if err := encoder.Encode(timelineitems); err != nil {
		http.Error(w, "Failed to convert to json", http.StatusInternalServerError)
		return
	}
}
