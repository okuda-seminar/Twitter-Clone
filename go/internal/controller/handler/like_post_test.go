package handler

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/openapi"
)

func TestLikePost(t *testing.T) {
	authorUserID := uuid.NewString()
	likerUserID := uuid.NewString()
	postID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		requestBody  openapi.LikePostRequest
		setup        func(likePostUsecase usecase.LikePostUsecase)
		expectedCode int
	}{
		"returns 204 when the author likes own post successfully": {
			userID:       authorUserID,
			requestBody:  openapi.LikePostRequest{PostId: postID},
			expectedCode: http.StatusNoContent,
		},
		"returns 204 when a user likes another user's post successfully": {
			userID:       likerUserID,
			requestBody:  openapi.LikePostRequest{PostId: postID},
			expectedCode: http.StatusNoContent,
		},
		"returns 404 when user or post does not exist": {
			userID:      uuid.NewString(),
			requestBody: openapi.LikePostRequest{PostId: postID},
			setup: func(likePostUsecase usecase.LikePostUsecase) {
				likePostUsecase.SetError(usecase.ErrUserOrPostNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
		"returns 409 when post is already liked": {
			userID:      likerUserID,
			requestBody: openapi.LikePostRequest{PostId: postID},
			setup: func(likePostUsecase usecase.LikePostUsecase) {
				likePostUsecase.SetError(usecase.ErrAlreadyLiked)
			},
			expectedCode: http.StatusConflict,
		},
		"returns 500 when unexpected error occurs": {
			userID:      likerUserID,
			requestBody: openapi.LikePostRequest{PostId: postID},
			setup: func(likePostUsecase usecase.LikePostUsecase) {
				likePostUsecase.SetError(fmt.Errorf("unexpected error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			likePostUsecase := usecaseInjector.InjectLikePostUsecase(nil)
			likePostHandler := NewLikePostHandler(likePostUsecase)

			if tt.setup != nil {
				tt.setup(likePostUsecase)
			}

			reqBody, _ := json.Marshal(tt.requestBody)
			req := httptest.NewRequest(
				"POST",
				fmt.Sprintf("/api/users/%s/likes", tt.userID),
				bytes.NewBuffer(reqBody),
			)
			rr := httptest.NewRecorder()

			likePostHandler.LikePost(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
