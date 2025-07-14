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
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/openapi"
)

func TestBlockUser(t *testing.T) {
	sourceUserID := uuid.NewString()
	targetUserID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		requestBody  openapi.BlockUserRequest
		setup        func(blockUserUsecase usecase.BlockUserUsecase)
		expectedCode int
	}{
		"returns 201 when user is blocked successfully": {
			userID:       sourceUserID,
			requestBody:  openapi.BlockUserRequest{TargetUserId: targetUserID},
			expectedCode: http.StatusCreated,
		},
		"returns 500 when user is not found": {
			userID:      sourceUserID,
			requestBody: openapi.BlockUserRequest{TargetUserId: uuid.NewString()},
			setup: func(blockUserUsecase usecase.BlockUserUsecase) {
				blockUserUsecase.SetError(repository.ErrForeignViolation)
			},
			expectedCode: http.StatusInternalServerError,
		},
		"returns 500 when user is already blocked": {
			userID:      sourceUserID,
			requestBody: openapi.BlockUserRequest{TargetUserId: targetUserID},
			setup: func(blockUserUsecase usecase.BlockUserUsecase) {
				blockUserUsecase.SetError(repository.ErrUniqueViolation)
			},
			expectedCode: http.StatusInternalServerError,
		},
		"returns 500 when unexpected error occurs": {
			userID:      sourceUserID,
			requestBody: openapi.BlockUserRequest{TargetUserId: targetUserID},
			setup: func(blockUserUsecase usecase.BlockUserUsecase) {
				blockUserUsecase.SetError(fmt.Errorf("unexpected error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			blockUserUsecase := usecaseInjector.InjectBlockUserUsecase(nil)
			blockUserHandler := NewBlockUserHandler(blockUserUsecase)

			if tt.setup != nil {
				tt.setup(blockUserUsecase)
			}

			reqBody, _ := json.Marshal(tt.requestBody)
			req := httptest.NewRequest(
				"POST",
				fmt.Sprintf("/api/users/%s/blocking", tt.userID),
				bytes.NewBuffer(reqBody),
			)
			rr := httptest.NewRecorder()

			blockUserHandler.BlockUser(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
