package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/entity"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
)

func TestGetUserPostsTimeline(t *testing.T) {
	userID := uuid.NewString()
	tests := map[string]struct {
		setup        func(specificUserPostsUsecase usecase.SpecificUserPostsUsecase)
		expectedCode int
	}{
		"returns 200 when user posts are retrieved successfully": {
			setup: func(specificUserPostsUsecase usecase.SpecificUserPostsUsecase) {
				specificUserPostsUsecase.SetPosts([]*entity.TimelineItem{
					{
						Type:      entity.PostTypePost,
						ID:        uuid.NewString(),
						AuthorID:  userID,
						Text:      "test post",
						CreatedAt: time.Now(),
					},
				})
			},
			expectedCode: http.StatusOK,
		},
		"returns 200 when user posts are empty": {
			expectedCode: http.StatusOK,
		},
		"returns 500 when there is a server error": {
			setup: func(specificUserPostsUsecase usecase.SpecificUserPostsUsecase) {
				specificUserPostsUsecase.SetError(ErrGetTimeLineItemsFailed)
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			timeLineItemsRepository := infraInjector.InjectTimelineItemsRepository(nil, nil)
			specificUserPostsUsecase := usecaseInjector.InjectSpecificUserPostsUsecase(timeLineItemsRepository)
			getUserPostsTimelineHandler := NewGetUserPostsTimelineHandler(specificUserPostsUsecase)

			if tt.setup != nil {
				tt.setup(specificUserPostsUsecase)
			}

			rr := httptest.NewRecorder()
			req := httptest.NewRequest(
				http.MethodGet,
				fmt.Sprintf("/api/users/%s/posts", userID),
				nil,
			)

			getUserPostsTimelineHandler.GetUserPostsTimeline(rr, req, userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
