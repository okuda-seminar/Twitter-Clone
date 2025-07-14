package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
)

func TestUnlikePost(t *testing.T) {
	userID := uuid.NewString()
	postID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		postID       string
		setup        func(unlikePostUsecase usecase.UnlikePostUsecase)
		expectedCode int
	}{
		"returns 204 when a user unlikes a post successfully": {
			userID:       userID,
			postID:       postID,
			expectedCode: http.StatusNoContent,
		},
		"returns 500 when there is a server error": {
			userID: uuid.NewString(),
			postID: postID,
			setup: func(unlikePostUsecase usecase.UnlikePostUsecase) {
				unlikePostUsecase.SetError(fmt.Errorf("unexpected error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
		"returns 404 when user exists and post does not exist": {
			userID: userID,
			postID: uuid.NewString(),
			setup: func(unlikePostUsecase usecase.UnlikePostUsecase) {
				unlikePostUsecase.SetError(usecase.ErrLikeNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			unlikePostUsecase := usecaseInjector.InjectUnlikePostUsecase(nil)
			unlikePostHandler := NewUnlikePostHandler(unlikePostUsecase)

			if tt.setup != nil {
				tt.setup(unlikePostUsecase)
			}

			req := httptest.NewRequest(
				"DELETE",
				fmt.Sprintf("/api/users/%s/likes/%s", tt.userID, tt.postID),
				strings.NewReader(""),
			)
			rr := httptest.NewRecorder()

			unlikePostHandler.UnlikePost(rr, req, tt.userID, tt.postID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
