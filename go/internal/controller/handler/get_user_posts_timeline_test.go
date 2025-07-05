package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
)

func TestGetUserPostsTimeline(t *testing.T) {
	tests := map[string]struct {
		setup        func(specificUserPostsUsecase usecase.SpecificUserPostsUsecase)
		expectedCode int
	}{
		"returns 200 when user posts are retrieved successfully": {
			expectedCode: http.StatusOK,
		},
		"returns 200 when user posts are empty": {
			expectedCode: http.StatusOK,
		},
		"returns 500 when there is a server error": {
			setup: func(specificUserPostsUsecase usecase.SpecificUserPostsUsecase) {
				specificUserPostsUsecase.SetError(ErrGetTimeLineItemsFailed)
			},
			expectedCode: 500,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			timeLineItemsRepository := infraInjector.InjectTimelineItemsRepository(nil)
			createPostUsecase := usecaseInjector.InjectCreatePostUsecase(timeLineItemsRepository)
			specificUserPostsUsecase := usecaseInjector.InjectSpecificUserPostsUsecase(timeLineItemsRepository)
			getUserPostsTimelineHandler := NewGetUserPostsTimelineHandler(specificUserPostsUsecase)

			if tt.setup != nil {
				tt.setup(specificUserPostsUsecase)
			}

			userID := uuid.NewString()

			rr := httptest.NewRecorder()
			req := httptest.NewRequest(
				http.MethodGet,
				fmt.Sprintf("/api/users/%s/posts", userID),
				nil,
			)

			if name == "returns 200 when user posts are retrieved successfully" {
				createPostUsecase.CreatePost(userID, "test post")
			}

			getUserPostsTimelineHandler.GetUserPostsTimeline(rr, req, userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
