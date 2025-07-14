package handler

import (
	"bufio"
	"context"
	"encoding/json"
	"net/http/httptest"
	"strings"
	"sync"
	"testing"
	"time"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/value"
)

func TestGetReverseChronologicalHomeTimeline(t *testing.T) {
	targetUserID := uuid.NewString()
	tests := map[string]struct {
		setup         func(userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase, updateNotificationUsecase usecase.UpdateNotificationUsecase)
		eventType     string
		timelineItem  *entity.TimelineItem
		expectedCount int
	}{
		"get only a target user posts": {
			setup: func(userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase, updateNotificationUsecase usecase.UpdateNotificationUsecase) {
				userAndFolloweePostsUsecase.SetTimelineItems([]*entity.TimelineItem{
					{
						Type:      entity.PostTypePost,
						ID:        uuid.NewString(),
						AuthorID:  targetUserID,
						Text:      "test",
						CreatedAt: time.Now(),
					},
				})
			},
			expectedCount: 1,
		},
		"get a target user and following users posts": {
			setup: func(userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase, updateNotificationUsecase usecase.UpdateNotificationUsecase) {
				userAndFolloweePostsUsecase.SetTimelineItems([]*entity.TimelineItem{
					{
						Type:      entity.PostTypePost,
						ID:        uuid.NewString(),
						AuthorID:  targetUserID,
						Text:      "test 1",
						CreatedAt: time.Now(),
					},
					{
						Type:      entity.PostTypePost,
						ID:        uuid.NewString(),
						AuthorID:  uuid.NewString(),
						Text:      "test 2",
						CreatedAt: time.Now(),
					},
				})
			},
			expectedCount: 2,
		},
		"get no posts": {
			expectedCount: 0,
		},
		"get posts posted during timeline access": {
			expectedCount: 1,
			eventType:     entity.PostCreated,
			timelineItem: &entity.TimelineItem{
				Type:      entity.PostTypePost,
				ID:        uuid.NewString(),
				AuthorID:  targetUserID,
				Text:      "test 1",
				CreatedAt: time.Now(),
			},
		},
		"get posts deleted during timeline access": {
			expectedCount: 1,
			eventType:     entity.PostDeleted,
			timelineItem: &entity.TimelineItem{
				Type:      entity.PostTypePost,
				ID:        uuid.NewString(),
				AuthorID:  targetUserID,
				Text:      "test 1",
				CreatedAt: time.Now(),
			},
		},
		"get a repost posted during timeline access": {
			expectedCount: 1,
			eventType:     entity.RepostCreated,
			timelineItem: &entity.TimelineItem{
				Type:         entity.PostTypeRepost,
				ID:           uuid.NewString(),
				AuthorID:     targetUserID,
				ParentPostID: value.NullUUID{UUID: uuid.NewString(), Valid: true},
				Text:         "",
				CreatedAt:    time.Now(),
			},
		},
		"get reposts deleted during timeline access": {
			expectedCount: 1,
			eventType:     entity.RepostDeleted,
			timelineItem: &entity.TimelineItem{
				Type:         entity.PostTypeRepost,
				ID:           uuid.NewString(),
				AuthorID:     targetUserID,
				ParentPostID: value.NullUUID{UUID: uuid.NewString(), Valid: true},
				Text:         "",
				CreatedAt:    time.Now(),
			},
		},
		"get a quote repost posted during timeline access": {
			expectedCount: 1,
			eventType:     entity.QuoteRepostCreated,
			timelineItem: &entity.TimelineItem{
				Type:         entity.PostTypeQuoteRepost,
				ID:           uuid.NewString(),
				AuthorID:     targetUserID,
				ParentPostID: value.NullUUID{UUID: uuid.NewString(), Valid: true},
				Text:         "quote repost",
				CreatedAt:    time.Now(),
			},
		},
		"get a quote repost deleted during timeline access": {
			expectedCount: 1,
			// quoteRepost and repost deletion are performed on the same endpoint, event type is repostDeleted
			eventType: entity.RepostDeleted,
			timelineItem: &entity.TimelineItem{
				Type:         entity.PostTypeQuoteRepost,
				ID:           uuid.NewString(),
				AuthorID:     targetUserID,
				ParentPostID: value.NullUUID{UUID: uuid.NewString(), Valid: true},
				Text:         "quote repost",
				CreatedAt:    time.Now(),
			},
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			connected := make(chan struct{})
			userAndFolloweePostsUsecase := usecaseInjector.InjectUserAndFolloweePostsUsecase(nil)
			updateNotificationUsecase := usecaseInjector.InjectUpdateNotificationUsecase(nil)
			getReverseChronologicalHomeTimelineHandler := NewGetReverseChronologicalHomeTimelineHandler(userAndFolloweePostsUsecase, updateNotificationUsecase, connected)

			if tt.setup != nil {
				tt.setup(userAndFolloweePostsUsecase, updateNotificationUsecase)
			}

			ctx, cancel := context.WithTimeout(context.Background(), 200*time.Millisecond)
			defer cancel()
			rr := httptest.NewRecorder()
			req := httptest.NewRequest(
				"GET",
				"/api/users/{id}/timelines/reverse_chronological",
				nil,
			).WithContext(ctx)
			req.SetPathValue("id", targetUserID)

			var wg sync.WaitGroup

			wg.Add(1)
			go func() {
				defer wg.Done()
				getReverseChronologicalHomeTimelineHandler.GetReverseChronologicalHomeTimeline(rr, req, targetUserID)
			}()
			var timelineitems []entity.TimelineItem

			// This channel indicates that the httptest client has successfully connected to the handler.
			// Wait here to ensure that the connection is established before triggering timeline updates.
			<-connected

			// updateNotificationUsecase sends notifications
			// to replace creation and deletion of posts, reposts, and quotereposts during timeline connections.
			if tt.timelineItem != nil {
				updateNotificationUsecase.SendNotification(uuid.NewString(), tt.eventType, tt.timelineItem)
			}

			wg.Wait()
			scanner := bufio.NewScanner(rr.Body)

			for scanner.Scan() {
				line := scanner.Text()
				if strings.HasPrefix(line, "data:") {
					jsonData := strings.TrimPrefix(line, "data: ")
					var timelineEvent entity.TimelineEvent

					err := json.Unmarshal([]byte(jsonData), &timelineEvent)
					if err != nil {
						t.Errorf("Failed to decode JSON: %v", err)
					}
					for _, timelineitem := range timelineEvent.TimelineItems {
						timelineitems = append(timelineitems, *timelineitem)
					}
				}
			}

			if len(timelineitems) != tt.expectedCount {
				t.Errorf("%s: wrong number of posts returned; expected %d, but got timelineitems: %d", name, tt.expectedCount, len(timelineitems))
			}
		})
	}
}
