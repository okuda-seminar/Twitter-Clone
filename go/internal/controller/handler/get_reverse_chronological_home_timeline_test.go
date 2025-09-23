package handler

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func TestGetReverseChronologicalHomeTimeline(t *testing.T) {
	targetUserID := uuid.NewString()
	tests := map[string]struct {
		setup         func(userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase)
		expectedCount int
	}{
		"get only a target user posts": {
			setup: func(userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase) {
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
			setup: func(userAndFolloweePostsUsecase usecase.UserAndFolloweePostsUsecase) {
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
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			userAndFolloweePostsUsecase := usecaseInjector.InjectUserAndFolloweePostsUsecase(nil)
			getReverseChronologicalHomeTimelineHandler := NewGetReverseChronologicalHomeTimelineHandler(userAndFolloweePostsUsecase)

			if tt.setup != nil {
				tt.setup(userAndFolloweePostsUsecase)
			}

			rr := httptest.NewRecorder()
			req := httptest.NewRequest(
				http.MethodGet,
				"/api/users/{id}/timelines/reverse_chronological",
				nil,
			)
			req.SetPathValue("id", targetUserID)

			getReverseChronologicalHomeTimelineHandler.GetReverseChronologicalHomeTimeline(rr, req, targetUserID)

			if rr.Code != 200 {
				t.Errorf("Expected status 200, got %d", rr.Code)
				return
			}

			var response openapi.GetReverseChronologicalHomeTimelineResponse
			err := json.Unmarshal(rr.Body.Bytes(), &response)
			if err != nil {
				t.Errorf("Failed to decode JSON: %v", err)
			}

			if len(response) != tt.expectedCount {
				t.Errorf("%s: wrong number of posts returned; expected %d, but got timelineitems: %d", name, tt.expectedCount, len(response))
			}
		})
	}
}
