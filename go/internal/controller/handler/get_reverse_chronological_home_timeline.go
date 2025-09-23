package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
)

type GetReverseChronologicalHomeTimelineHandler struct {
	userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase
}

func NewGetReverseChronologicalHomeTimelineHandler(
	userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase,
) GetReverseChronologicalHomeTimelineHandler {
	return GetReverseChronologicalHomeTimelineHandler{
		userAndFolloweePostsUsecase,
	}
}

// GetReverseChronologicalHomeTimeline gets posts whose user_id is user or following user from posts table.
func (h *GetReverseChronologicalHomeTimelineHandler) GetReverseChronologicalHomeTimeline(w http.ResponseWriter, r *http.Request, userID string) {
	timelineitems, err := h.userAndFolloweePostsUsecase.UserAndFolloweePosts(userID)
	if err != nil {
		http.Error(w, ErrUserAndFolloweePosts.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	encoder := json.NewEncoder(w)
	if err := encoder.Encode(timelineitems); err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
