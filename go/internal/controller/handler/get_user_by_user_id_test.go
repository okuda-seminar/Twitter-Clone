package handler_test

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/controller/handler"
)

func TestGetUserByUserID(t *testing.T) {
	existingUserID := uuid.NewString()
	nonExistentUserID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		setup        func(userByUserIDUsecase usecase.UserByUserIDUsecase)
		expectedCode int
	}{
		"returns 200 when user exists": {
			userID:       existingUserID,
			expectedCode: http.StatusOK,
		},
		"returns 404 when user does not exist": {
			userID: nonExistentUserID,
			setup: func(userByUserIDUsecase usecase.UserByUserIDUsecase) {
				userByUserIDUsecase.SetError(usecase.ErrUserNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			userByUserIDUsecase := usecaseInjector.InjectUserByUserIDUsecase(nil, nil)
			getUserByUserIDHandler := handler.NewGetUserByUserIDHandler(userByUserIDUsecase)

			if tt.setup != nil {
				tt.setup(userByUserIDUsecase)
			}

			req := httptest.NewRequest(
				"GET",
				fmt.Sprintf("/api/users/%s", tt.userID),
				nil,
			)
			rr := httptest.NewRecorder()

			getUserByUserIDHandler.GetUserByUserID(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
