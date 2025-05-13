package handler

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/google/uuid"

	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure"
	"x-clone-backend/internal/openapi"
)

func TestCreatePost(t *testing.T) {
	nonExistentUserID := uuid.NewString()
	existentUserID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		text         string
		err          error
		expectedCode int
	}{
		"create post": {
			userID:       existentUserID,
			text:         "test",
			err:          nil,
			expectedCode: http.StatusCreated,
		},
		"non-existent userID": {
			userID:       nonExistentUserID,
			text:         "test",
			err:          repository.ErrForeignViolation,
			expectedCode: http.StatusBadRequest,
		},
		"too-long text": {
			userID:       existentUserID,
			text:         strings.Repeat("a", 141),
			err:          nil,
			expectedCode: http.StatusBadRequest,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			timelineItemsRepository := infrastructure.InjectTimelineItemsRepository(nil)
			usersRepository := infrastructure.InjectUsersRepository(nil)
			createPostUsecase := interactor.NewCreatePostUsecase(timelineItemsRepository)
			updateNotificationUsecase := interactor.NewUpdateNotificationUsecase(usersRepository)
			createPostHandler := NewCreatePostHandler(updateNotificationUsecase, createPostUsecase)

			if tt.err != nil {
				timelineItemsRepository.SetError(repository.ErrKeyCreatePost, tt.err)
			}

			body, err := json.Marshal(openapi.CreatePostRequest{
				Text: tt.text,
			})
			if err != nil {
				t.Errorf("failed to marshal request body: %v", err)
			}

			req := httptest.NewRequest(
				"POST",
				fmt.Sprintf("/api/%s/posts", tt.userID),
				bytes.NewReader(body),
			)
			rr := httptest.NewRecorder()
			createPostHandler.CreatePost(rr, req, tt.userID)
			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}

			timelineItemsRepository.ClearError(repository.ErrKeyCreatePost)
		})
	}
}
