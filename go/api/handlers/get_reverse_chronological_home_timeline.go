package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"x-clone-backend/internal/app/usecases"
	"x-clone-backend/internal/domain/entities"
	infrastructure "x-clone-backend/internal/infrastructure/persistence"
)

type GetReverseChronologicalHomeTimelineHandler struct {
	db                             *sql.DB
	mu                             *sync.Mutex
	usersChan                      *map[string]chan entities.TimelineEvent
	getUserAndFolloweePostsUsecase usecases.GetUserAndFolloweePostsUsecase
}

func NewGetReverseChronologicalHomeTimelineHandler(db *sql.DB, mu *sync.Mutex, usersChan *map[string]chan entities.TimelineEvent) GetReverseChronologicalHomeTimelineHandler {
	postsRepository := infrastructure.NewPostsRepository(db)
	getUserAndFolloweePostsUsecase := usecases.NewGetUserAndFolloweePostsUsecase(postsRepository)
	return GetReverseChronologicalHomeTimelineHandler{
		db:                             db,
		mu:                             mu,
		usersChan:                      usersChan,
		getUserAndFolloweePostsUsecase: getUserAndFolloweePostsUsecase,
	}
}

// GetReverseChronologicalHomeTimeline gets posts whose user_id is user or following user from posts table.
func (h *GetReverseChronologicalHomeTimelineHandler) GetReverseChronologicalHomeTimeline(w http.ResponseWriter, r *http.Request, userID string) {
	posts, err := h.getUserAndFolloweePostsUsecase.GetUserAndFolloweePosts(userID)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not get posts"), http.StatusInternalServerError)
		return
	}

	h.mu.Lock()
	if _, exists := (*h.usersChan)[userID]; !exists {
		(*h.usersChan)[userID] = make(chan entities.TimelineEvent, 1)
	}
	userChan := (*h.usersChan)[userID]
	h.mu.Unlock()

	userChan <- entities.TimelineEvent{EventType: entities.TimelineAccessed, Posts: posts}

	flusher, _ := w.(http.Flusher)
	w.Header().Set("Content-Type", "text/event-stream")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Connection", "keep-alive")

	for {
		select {
		case event := <-userChan:
			jsonData, err := json.Marshal(event)
			if err != nil {
				log.Println(err)
				return
			}

			fmt.Fprintf(w, "data: %s\n\n", jsonData)
			flusher.Flush()
		case <-r.Context().Done():
			h.mu.Lock()
			delete(*h.usersChan, userID)
			h.mu.Unlock()
			return
		}
	}
}
