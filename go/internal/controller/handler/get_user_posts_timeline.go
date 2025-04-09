package handler

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/infrastructure/persistence"
)

type GetUserPostsTimelineHandler struct {
	specificUserPostsUsecase usecase.SpecificUserPostsUsecase
}

func NewGetUserPostsTimelineHandler(db *sql.DB) GetUserPostsTimelineHandler {
	timelineitemsRepository := persistence.NewTimelineitemsRepository(db)
	specificUserPostsUsecase := interactor.NewSpecificUserPostsUsecase(timelineitemsRepository)
	return GetUserPostsTimelineHandler{
		specificUserPostsUsecase: specificUserPostsUsecase,
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
