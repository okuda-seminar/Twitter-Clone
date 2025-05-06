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
	nonExistentUserID, err := uuid.NewUUID()
	if err != nil {
		t.Error("failed to generate userID")
	}
	existentUserID, err := uuid.NewUUID()
	if err != nil {
		t.Error("failed to generate userID")
	}
	tests := map[string]struct {
		userID       uuid.UUID
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

	for name, tc := range tests {
		t.Run(name, func(t *testing.T) {
			timelineItemsRepository := infrastructure.InjecttimelineItemsRepository(nil)
			usersRepository := infrastructure.InjectUsersRepository(nil)
			updateNotificationUsecase := interactor.NewUpdateNotificationUsecase(usersRepository)
			createPostHandler := NewCreatePostHandler(updateNotificationUsecase, timelineItemsRepository)

			if tc.err != nil {
				timelineItemsRepository.SetError(repository.ErrKeyCreatePost, tc.err)
			}

			body, err := json.Marshal(openapi.CreatePostRequest{
				Text: tc.text,
			})
			if err != nil {
				t.Errorf("failed to marshal request body: %v", err)
			}

			req := httptest.NewRequest(
				"POST",
				fmt.Sprintf("/api/%s/posts", tc.userID),
				bytes.NewReader(body),
			)
			rr := httptest.NewRecorder()
			createPostHandler.CreatePost(rr, req, tc.userID)
			if rr.Code != tc.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tc.expectedCode, rr.Code)
			}

			timelineItemsRepository.ClearError(repository.ErrKeyCreatePost)
		})
	}
}
