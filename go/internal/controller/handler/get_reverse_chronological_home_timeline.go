package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
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

	res, err := transfer.ToGetReverseChronologicalHomeTimelineResponse(timelineitems)
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
