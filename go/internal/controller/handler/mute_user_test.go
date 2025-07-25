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

func TestMuteUser(t *testing.T) {
	existingUserID := uuid.NewString()
	targetUserID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		requestBody  string
		setup        func(usecase.MuteUserUsecase)
		expectedCode int
	}{
		"returns 201 when muting succeeds": {
			userID:       existingUserID,
			requestBody:  fmt.Sprintf(`{"target_user_id": "%s"}`, targetUserID),
			expectedCode: http.StatusCreated,
		},
		"returns 500 when user does not exist": {
			userID:      uuid.NewString(),
			requestBody: fmt.Sprintf(`{"target_user_id": "%s"}`, targetUserID),
			setup: func(muteUserUsecase usecase.MuteUserUsecase) {
				muteUserUsecase.SetError(usecase.ErrUserNotFound)
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			muteUserUsecase := usecaseInjector.InjectMuteUserUsecase(nil)
			muteUserHandler := NewMuteUserHandler(muteUserUsecase)

			if tt.setup != nil {
				tt.setup(muteUserUsecase)
			}

			req := httptest.NewRequest(
				"POST",
				fmt.Sprintf("/api/users/%s/muting", tt.userID),
				strings.NewReader(tt.requestBody),
			)
			req.Header.Set("Content-Type", "application/json")
			rr := httptest.NewRecorder()

			muteUserHandler.MuteUser(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
