package handler

import (
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
)

func TestDeletePost(t *testing.T) {
	tests := map[string]struct {
		setup        func(deletePostUsecase usecase.DeletePostUsecase)
		expectedCode int
	}{
		"returns 204 when post is deleted successfully": {
			expectedCode: http.StatusNoContent,
		},
		"returns 500 when there is a server error": {
			setup: func(deletePostUsecase usecase.DeletePostUsecase) {
				deletePostUsecase.SetError(errors.New("Could not delete a post"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			timelineItemsRepository := infraInjector.InjectTimelineItemsRepository(nil)
			usersRepository := infraInjector.InjectUsersRepository(nil)
			deletePostUsecase := usecaseInjector.InjectDeletePostUsecase(timelineItemsRepository)
			updateNotificationUsecase := usecaseInjector.InjectUpdateNotificationUsecase(usersRepository)
			deletePostHandler := NewDeletePostHandler(deletePostUsecase, updateNotificationUsecase)

			if tt.setup != nil {
				tt.setup(deletePostUsecase)
			}

			postID := uuid.NewString()

			rr := httptest.NewRecorder()
			req := httptest.NewRequest(
				http.MethodDelete,
				fmt.Sprintf("/api/posts/%s", postID),
				nil,
			)
			deletePostHandler.DeletePost(rr, req, postID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
