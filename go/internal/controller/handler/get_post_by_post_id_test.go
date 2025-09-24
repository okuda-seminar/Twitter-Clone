package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	"x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/repository"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
)

func TestGetPostByPostID(t *testing.T) {
	tests := map[string]struct {
		setupPost    func(timelineItemsRepository repository.TimelineItemsRepository) string
		expectedCode int
	}{
		"successfully get the specified post": {
			setupPost: func(timelineItemsRepository repository.TimelineItemsRepository) string {
				post, _ := timelineItemsRepository.CreatePost(uuid.NewString(), "test", []string{})
				return post.ID
			},
			expectedCode: http.StatusOK,
		},
		"successfully get the specified repost": {
			setupPost: func(timelineItemsRepository repository.TimelineItemsRepository) string {
				post, _ := timelineItemsRepository.CreatePost(uuid.NewString(), "test", []string{})
				repost, _ := timelineItemsRepository.CreateRepost(uuid.NewString(), post.ID)
				return repost.ID
			},
			expectedCode: http.StatusOK,
		},
		"successfully get the specified quote repost": {
			setupPost: func(timelineItemsRepository repository.TimelineItemsRepository) string {
				post, _ := timelineItemsRepository.CreatePost(uuid.NewString(), "test", []string{})
				quoteRepost, _ := timelineItemsRepository.CreateQuoteRepost(uuid.NewString(), post.ID, "quote repost")
				return quoteRepost.ID
			},
			expectedCode: http.StatusOK,
		},
		"the specified post is not found": {
			setupPost: func(timelineItemsRepository repository.TimelineItemsRepository) string {
				return uuid.NewString()
			},
			expectedCode: http.StatusNotFound,
		},
		"Unknown error": {
			setupPost: func(timelineItemsRepository repository.TimelineItemsRepository) string {
				timelineItemsRepository.SetError(repository.ErrKeyRetrieveTimelineItem, fmt.Errorf("Unknown Error"))
				return uuid.NewString()
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			timelineItemsRepository := infraInjector.InjectTimelineItemsRepository(nil, nil)
			getPostByPostIDUsecase := injector.InjectGetPostByPostIDUsecase(&timelineItemsRepository)
			getPostByPostIDHandler := NewGetPostByPostIDHandler(getPostByPostIDUsecase)

			postID := tt.setupPost(timelineItemsRepository)

			rr := httptest.NewRecorder()
			req := httptest.NewRequest(
				http.MethodDelete,
				fmt.Sprintf("/api/posts/%s", postID),
				nil,
			)
			getPostByPostIDHandler.GetPostByPostID(rr, req, postID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
