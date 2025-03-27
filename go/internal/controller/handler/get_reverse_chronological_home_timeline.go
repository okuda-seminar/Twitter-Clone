package handler

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/infrastructure/persistence"
	"x-clone-backend/internal/lib/featureflag"
)

type GetReverseChronologicalHomeTimelineHandler struct {
	db                             *sql.DB
	mu                             *sync.Mutex
	usersChan                      *map[string]chan entity.TimelineEvent
	getUserAndFolloweePostsUsecase usecase.GetUserAndFolloweePostsUsecase
	userAndFolloweePostsUsecase    usecase.UserAndFolloweePostsUsecase
	connected                      chan struct{}
}

func NewGetReverseChronologicalHomeTimelineHandler(db *sql.DB, mu *sync.Mutex, usersChan *map[string]chan entity.TimelineEvent, connected chan struct{}) GetReverseChronologicalHomeTimelineHandler {
	postsRepository := persistence.NewPostsRepository(db)
	timelineitemsRepository := persistence.NewTimelineitemsRepository(db)
	getUserAndFolloweePostsUsecase := interactor.NewGetUserAndFolloweePostsUsecase(postsRepository)
	userAndFolloweePostsUsecase := interactor.NewUserAndFolloweePostsUsecase(timelineitemsRepository)
	return GetReverseChronologicalHomeTimelineHandler{
		db:                             db,
		mu:                             mu,
		usersChan:                      usersChan,
		getUserAndFolloweePostsUsecase: getUserAndFolloweePostsUsecase,
		userAndFolloweePostsUsecase:    userAndFolloweePostsUsecase,
		connected:                      connected,
	}
}

// GetReverseChronologicalHomeTimeline gets posts whose user_id is user or following user from posts table.
func (h *GetReverseChronologicalHomeTimelineHandler) GetReverseChronologicalHomeTimeline(w http.ResponseWriter, r *http.Request, userID string) {
	h.mu.Lock()
	if _, exists := (*h.usersChan)[userID]; !exists {
		(*h.usersChan)[userID] = make(chan entity.TimelineEvent, 1)
	}
	userChan := (*h.usersChan)[userID]
	h.mu.Unlock()

	if featureflag.TimelineFeatureFlag().UseNewSchema {
		timelineitems, err := h.userAndFolloweePostsUsecase.UserAndFolloweePosts(userID)
		if err != nil {
			http.Error(w, fmt.Sprintln("Could not get timelineitems"), http.StatusInternalServerError)
			return
		}

		userChan <- entity.TimelineEvent{EventType: entity.TimelineAccessed, TimelineItems: timelineitems}
		h.connected <- struct{}{}

		flusher, _ := w.(http.Flusher)
		w.Header().Set("Content-Type", "text/event-stream")
		w.Header().Set("Cache-Control", "no-cache")
		w.Header().Set("Connection", "keep-alive")

		for {
			select {
			case <-h.connected:
				continue
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
	} else {
		posts, err := h.getUserAndFolloweePostsUsecase.GetUserAndFolloweePosts(userID)
		if err != nil {
			http.Error(w, fmt.Sprintln("Could not get posts"), http.StatusInternalServerError)
			return
		}

		userChan <- entity.TimelineEvent{EventType: entity.TimelineAccessed, Posts: posts}
		h.connected <- struct{}{}

		flusher, _ := w.(http.Flusher)
		w.Header().Set("Content-Type", "text/event-stream")
		w.Header().Set("Cache-Control", "no-cache")
		w.Header().Set("Connection", "keep-alive")

		for {
			select {
			case <-h.connected:
				continue
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
}
