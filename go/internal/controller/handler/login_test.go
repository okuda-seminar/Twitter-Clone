package handler

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/infrastructure"
	"x-clone-backend/internal/openapi"
)

func TestLoginHandler(t *testing.T) {
	username := "testuser"
	password := "securepassword"

	tests := map[string]struct {
		requestBody    openapi.LoginRequest
		expectedStatus int
		expectToken    bool
	}{
		"Valid Login": {
			requestBody:    openapi.LoginRequest{Username: username, Password: password},
			expectedStatus: http.StatusOK,
			expectToken:    true,
		},
		"Empty Username": {
			requestBody:    openapi.LoginRequest{Username: "", Password: password},
			expectedStatus: http.StatusBadRequest,
			expectToken:    false,
		},
		"Empty Password": {
			requestBody:    openapi.LoginRequest{Username: username, Password: ""},
			expectedStatus: http.StatusBadRequest,
			expectToken:    false,
		},
		"Invalid Username": {
			requestBody:    openapi.LoginRequest{Username: "wronguser", Password: password},
			expectedStatus: http.StatusNotFound,
			expectToken:    false,
		},
		"Invalid Password": {
			requestBody:    openapi.LoginRequest{Username: username, Password: "wrongpassword"},
			expectedStatus: http.StatusUnauthorized,
			expectToken:    false,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			usersRepository := infrastructure.InjectUsersRepository(nil)
			authService := service.NewAuthService("test_secret_key")
			loginUsecase := interactor.NewLoginUsecase(usersRepository, authService)
			loginHandler := NewLoginHandler(loginUsecase)

			// Fixture
			hashedPassword, _ := authService.HashPassword(password)
			createUserUsecase := interactor.NewCreateUserUsecase(usersRepository)
			createUserUsecase.CreateUser(username, "Test User", hashedPassword)

			reqBody, _ := json.Marshal(tt.requestBody)
			req := httptest.NewRequest(http.MethodPost, "/api/login", bytes.NewBuffer(reqBody))
			req.Header.Set("Content-Type", "application/json")

			rr := httptest.NewRecorder()
			loginHandler.Login(rr, req)

			if rr.Code != tt.expectedStatus {
				t.Errorf("%s: expected status %d, got %d", name, tt.expectedStatus, rr.Code)
			}

			if tt.expectToken {
				var resp openapi.LoginResponse
				err := json.Unmarshal(rr.Body.Bytes(), &resp)
				if err != nil {
					t.Fatalf("Failed to unmarshal response body: %v", err)
				}
				if resp.Token == "" {
					t.Errorf("Expected non-empty token in response, but it was empty")
				}
			}
		})
	}
}
