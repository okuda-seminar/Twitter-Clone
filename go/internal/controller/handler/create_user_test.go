package handler

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"x-clone-backend/internal/application/service"
	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
	"x-clone-backend/internal/openapi"
)

func TestCreateUser(t *testing.T) {
	tests := map[string]struct {
		requestBody  openapi.CreateUserRequest
		setup        func(createUserUsecase usecase.CreateUserUsecase)
		expectedCode int
	}{
		"returns 201 when user is created successfully": {
			requestBody: openapi.CreateUserRequest{
				Username:    "testuser",
				DisplayName: "Test User",
				Password:    "securepassword",
			},
			expectedCode: http.StatusCreated,
		},
		"returns 409 when username already exists": {
			requestBody: openapi.CreateUserRequest{
				Username:    "existinguser",
				DisplayName: "Existing User",
				Password:    "securepassword",
			},
			setup: func(createUserUsecase usecase.CreateUserUsecase) {
				createUserUsecase.SetError(usecase.ErrUserAlreadyExists)
			},
			expectedCode: http.StatusConflict,
		},
		"returns 500 when unexpected error occurs": {
			requestBody: openapi.CreateUserRequest{
				Username:    "testuser",
				DisplayName: "Test User",
				Password:    "securepassword",
			},
			setup: func(createUserUsecase usecase.CreateUserUsecase) {
				createUserUsecase.SetError(fmt.Errorf("unexpected error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			// Setup
			usersRepository := infraInjector.InjectUsersRepository(nil)
			createUserUsecase := usecaseInjector.InjectCreateUserUsecase(usersRepository)
			authService := service.NewAuthService("test_secret_key")
			createUserHandler := NewCreateUserHandler(authService, createUserUsecase)

			if tt.setup != nil {
				tt.setup(createUserUsecase)
			}

			// Create request
			reqBody, _ := json.Marshal(tt.requestBody)
			req := httptest.NewRequest(http.MethodPost, "/api/users", bytes.NewBuffer(reqBody))
			req.Header.Set("Content-Type", "application/json")
			rr := httptest.NewRecorder()

			// Execute
			createUserHandler.CreateUser(rr, req)

			// Assert status code
			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
