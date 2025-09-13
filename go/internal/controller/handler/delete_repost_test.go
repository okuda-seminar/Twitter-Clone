package handler

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
	"x-clone-backend/internal/openapi"
)

func TestDeleteRepost(t *testing.T) {
	tests := map[string]struct {
		setup        func(deleteRepostUsecase usecase.DeleteRepostUsecase)
		body         openapi.DeleteRepostRequest
		expectedCode int
	}{
		"returns 204 when repost is deleted successfully": {
			body:         openapi.DeleteRepostRequest{RepostId: uuid.NewString()},
			expectedCode: http.StatusNoContent,
		},
		"returns 500 when there is a server error": {
			setup: func(deleteRepostUsecase usecase.DeleteRepostUsecase) {
				deleteRepostUsecase.SetError(errors.New("Could not delete a repost"))
			},
			body:         openapi.DeleteRepostRequest{RepostId: uuid.NewString()},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			timelineItemsRepository := infraInjector.InjectTimelineItemsRepository(nil, nil)
			usersRepository := infraInjector.InjectUsersRepository(nil)
			deleteRepostUsecase := usecaseInjector.InjectDeleteRepostUsecase(timelineItemsRepository)
			updateNotificationUsecase := usecaseInjector.InjectUpdateNotificationUsecase(usersRepository)
			deleteRepostHandler := NewDeleteRepostHandler(deleteRepostUsecase, updateNotificationUsecase)

			if tt.setup != nil {
				tt.setup(deleteRepostUsecase)
			}

			userID := uuid.NewString()
			postID := uuid.NewString()

			reqBody, _ := json.Marshal(tt.body)
			req := httptest.NewRequest(
				http.MethodDelete,
				fmt.Sprintf("/api/users/%s/reposts/%s", userID, postID),
				bytes.NewReader(reqBody),
			)

			rr := httptest.NewRecorder()
			deleteRepostHandler.DeleteRepost(rr, req, userID, postID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
