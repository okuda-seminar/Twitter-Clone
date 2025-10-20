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
	"x-clone-backend/internal/openapi"
)

func TestCreateRepost(t *testing.T) {
	tests := map[string]struct {
		userID       string
		requestBody  openapi.CreateRepostRequest
		setup        func(createRepostUsecase usecase.CreateRepostUsecase)
		expectedCode int
	}{
		"returns 201 when repost is created successfully": {
			userID:       uuid.NewString(),
			requestBody:  openapi.CreateRepostRequest{PostId: uuid.NewString()},
			expectedCode: http.StatusCreated,
		},
		"returns 500 when failed to create a repost": {
			userID:      uuid.NewString(),
			requestBody: openapi.CreateRepostRequest{PostId: uuid.NewString()},
			setup: func(createRepostUsecase usecase.CreateRepostUsecase) {
				createRepostUsecase.SetError(errors.New("failed to create a repost"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			createRepostUsecase := usecaseInjector.InjectCreateRepostUsecase(nil, nil)
			updateNotificationUsecase := usecaseInjector.InjectUpdateNotificationUsecase(nil)
			createRepostHandler := NewCreateRepostHandler(createRepostUsecase, updateNotificationUsecase)

			if tt.setup != nil {
				tt.setup(createRepostUsecase)
			}

			reqBody, _ := json.Marshal(tt.requestBody)
			req := httptest.NewRequest(
				"POST",
				fmt.Sprintf("/api/users/%s/reposts", tt.userID),
				bytes.NewBuffer(reqBody),
			)
			rr := httptest.NewRecorder()

			createRepostHandler.CreateRepost(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
