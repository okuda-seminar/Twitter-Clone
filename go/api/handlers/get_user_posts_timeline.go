package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"
	"x-clone-backend/internal/app/usecases"
	infrastructure "x-clone-backend/internal/infrastructure/persistence"
)

type GetUserPostsTimelineHandler struct {
	getSpecificUserPostsUsecase usecases.GetSpecificUserPostsUsecase
}

func NewGetUserPostsTimelineHandler(db *sql.DB) GetUserPostsTimelineHandler {
	postsRepository := infrastructure.NewPostsRepository(db)
	getSpecificUserPostsUsecase := usecases.NewGetSpecificUserPostsUsecase(postsRepository)
	return GetUserPostsTimelineHandler{
		getSpecificUserPostsUsecase: getSpecificUserPostsUsecase,
	}
}

// GetUserPostsTimeline gets posts by a single user, specified by the requested user ID.
func (h *GetUserPostsTimelineHandler) GetUserPostsTimeline(w http.ResponseWriter, r *http.Request, id string) {
	posts, err := h.getSpecificUserPostsUsecase.GetSpecificUserPosts(id)
	if err != nil {
		http.Error(w, "Failed to get posts", http.StatusInternalServerError)
	}

	w.Header().Set("Content-Type", "application/json")
	encoder := json.NewEncoder(w)
	if err := encoder.Encode(posts); err != nil {
		http.Error(w, "Failed to convert to json", http.StatusInternalServerError)
		return
	}
}
