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
		"invalid parent post type": {
			userID:         existentUserID,
			text:           "test",
			parentPostType: entity.PostTypeRepost,
			errKey:         repository.ErrKeyCreateQuoteRepost,
			err:            nil,
			expectedCode:   http.StatusBadRequest,
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
			timelineItemsRepository := infraInjector.InjectTimelineItemsRepository(nil, nil)
			usersRepository := infraInjector.InjectUsersRepository(nil)
			updateNotificationUsecase := usecaseInjector.InjectUpdateNotificationUsecase(usersRepository)
			createQuoteRepostUsecase := usecaseInjector.InjectCreateQuoteRepostUsecase(timelineItemsRepository, usersRepository)
			CreateQuoteRepostHandler := NewCreateQuoteRepostHandler(createQuoteRepostUsecase, updateNotificationUsecase)

			var parentPost entity.TimelineItem
			var parentPostID string
			var err error

			postUserID := uuid.NewString()
			postText := "test"

			switch tt.parentPostType {
			case entity.PostTypePost:
				parentPost, err = timelineItemsRepository.CreatePost(postUserID, postText, []string{})
				if err != nil {
					t.Errorf("Failed to create a post")
				}
			case entity.PostTypeQuoteRepost:
				parentPost, err = timelineItemsRepository.CreatePost(postUserID, postText, []string{})
				if err != nil {
					t.Errorf("Failed to create a post")
				}
				parentPost, err = timelineItemsRepository.CreateQuoteRepost(postUserID, parentPost.ID, postText, []string{})
				if err != nil {
					t.Errorf("Failed to create a quote repost")
				}
			case entity.PostTypeRepost:
				parentPost, err = timelineItemsRepository.CreatePost(postUserID, postText, []string{})
				if err != nil {
					t.Errorf("Failed to create a post")
				}
				parentPost, err = timelineItemsRepository.CreateRepost(postUserID, parentPost.ID)
				if err != nil {
					t.Errorf("Failed to create ae repost")
				}
			}
			parentPostID = parentPost.ID

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
