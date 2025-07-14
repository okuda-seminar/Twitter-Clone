package handler

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type GetReverseChronologicalHomeTimelineHandler struct {
	userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase
	updateNotificationUsecase   usecase.UpdateNotificationUsecase
	connected                   chan struct{}
}

func NewGetReverseChronologicalHomeTimelineHandler(
	userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase,
	updateNotificationUsecase usecase.UpdateNotificationUsecase,
	connected chan struct{},
) GetReverseChronologicalHomeTimelineHandler {
	return GetReverseChronologicalHomeTimelineHandler{
		userAndFolloweePostsUsecase,
		updateNotificationUsecase,
		connected,
	}
}

// GetReverseChronologicalHomeTimeline gets posts whose user_id is user or following user from posts table.
func (h *GetReverseChronologicalHomeTimelineHandler) GetReverseChronologicalHomeTimeline(w http.ResponseWriter, r *http.Request, userID string) {
	userChan, err := h.updateNotificationUsecase.SetChannel(userID)
	if err != nil {
		http.Error(w, ErrSetChannel.Error(), http.StatusInternalServerError)
		return
	}

	timelineitems, err := h.userAndFolloweePostsUsecase.UserAndFolloweePosts(userID)
	if err != nil {
		http.Error(w, ErrUserAndFolloweePosts.Error(), http.StatusInternalServerError)
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
			h.updateNotificationUsecase.DeleteChannel(userID)
			return
		}
	}
}
