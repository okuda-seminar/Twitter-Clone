package handler

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/google/uuid"

	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
	"x-clone-backend/internal/openapi"
)

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/743
// - Add a test case for a repost violation
func TestCreateQuoteRepost(t *testing.T) {
	nonExistentUserID := uuid.NewString()
	existentUserID := uuid.NewString()

	tests := map[string]struct {
		userID         string
		text           string
		parentPostType string
		errKey         string
		err            error
		expectedCode   int
	}{
		"create a quote repost whose parent post is a post": {
			userID:         existentUserID,
			text:           "test",
			parentPostType: entity.PostTypePost,
			errKey:         repository.ErrKeyCreateQuoteRepost,
			err:            nil,
			expectedCode:   http.StatusCreated,
		},
		"create a quote repost whose parent post is a quote repost": {
			userID:         existentUserID,
			text:           "test",
			parentPostType: entity.PostTypeQuoteRepost,
			errKey:         repository.ErrKeyCreateQuoteRepost,
			err:            nil,
			expectedCode:   http.StatusCreated,
		},
		"non-existent userID": {
			userID:         nonExistentUserID,
			text:           "test",
			parentPostType: entity.PostTypePost,
			errKey:         repository.ErrKeyCreateQuoteRepost,
			err:            repository.ErrForeignViolation,
			expectedCode:   http.StatusBadRequest,
		},
		"non-existent parent postID": {
			userID:         nonExistentUserID,
			text:           "test",
			parentPostType: entity.PostTypePost,
			errKey:         repository.ErrKeyRetrieveTimelineItem,
			err:            repository.ErrRecordNotFound,
			expectedCode:   http.StatusBadRequest,
		},
		"too-long text": {
			userID:         existentUserID,
			text:           strings.Repeat("a", 141),
			errKey:         repository.ErrKeyCreateQuoteRepost,
			parentPostType: entity.PostTypePost,
			err:            nil,
			expectedCode:   http.StatusBadRequest,
		},
		"internal error": {
			userID:         existentUserID,
			text:           "valid text",
			errKey:         repository.ErrKeyCreateQuoteRepost,
			parentPostType: entity.PostTypePost,
			err:            errors.New("unexpected failure"),
			expectedCode:   http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			timelineItemsRepository := infraInjector.InjectTimelineItemsRepository(nil)
			usersRepository := infraInjector.InjectUsersRepository(nil)
			createPostUsecase := usecaseInjector.InjectCreatePostUsecase(timelineItemsRepository)
			updateNotificationUsecase := usecaseInjector.InjectUpdateNotificationUsecase(usersRepository)
			createQuoteRepostUsecase := usecaseInjector.InjectCreateQuoteRepostUsecase(timelineItemsRepository)
			CreateQuoteRepostHandler := NewCreateQuoteRepostHandler(createQuoteRepostUsecase, updateNotificationUsecase)

			var parentPostID string
			var err error

			switch tt.parentPostType {
			case entity.PostTypePost:
				parentPostID, err = newCreatePost(updateNotificationUsecase, createPostUsecase)
				if err != nil {
					t.Errorf("Failed to create a post")
				}
			case entity.PostTypeQuoteRepost:
				parentPostID, err = newCreatePost(updateNotificationUsecase, createPostUsecase)
				if err != nil {
					t.Errorf("Failed to create a post")
				}
				parentPostID, err = newCreateQuoteRepost(updateNotificationUsecase, createQuoteRepostUsecase, parentPostID)
				if err != nil {
					t.Errorf("Failed to create a quote repost")
				}
			}

			if tt.err != nil {
				timelineItemsRepository.SetError(tt.errKey, tt.err)
			}

			body, err := json.Marshal(openapi.CreateQuoteRepostRequest{
				PostId: parentPostID,
				Text:   tt.text,
			})
			if err != nil {
				t.Errorf("failed to marshal request body: %v", err)
			}

			req := httptest.NewRequest(
				"POST",
				fmt.Sprintf("/api/%s/quote_reposts", tt.userID),
				bytes.NewReader(body),
			)
			rr := httptest.NewRecorder()
			CreateQuoteRepostHandler.CreateQuoteRepost(rr, req, tt.userID)
			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d, %s", name, tt.expectedCode, rr.Code, rr.Body.String())
			}

			timelineItemsRepository.ClearError(repository.ErrKeyCreatePost)
		})
	}
}
