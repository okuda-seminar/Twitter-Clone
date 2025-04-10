package handler

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/infrastructure"
	"x-clone-backend/internal/openapi"
)

func TestCreateUser(t *testing.T) {
	t.Run("create user", func(t *testing.T) {
		repo := infrastructure.InjectUsersRepository(nil)
		authService := service.NewAuthService("test")
		createUserHandler := NewCreateUserHandler(repo, authService)

		body, err := json.Marshal(openapi.CreateUserRequest{
			Username:    "test",
			DisplayName: "test",
			Password:    "securepassword",
		})
		if err != nil {
			t.Errorf("failed to marshal request body: %v", err)
		}
		req := httptest.NewRequest("POST", "/api/users", bytes.NewReader(body))
		rr := httptest.NewRecorder()

		createUserHandler.CreateUser(rr, req)

		if rr.Code != http.StatusCreated {
			t.Errorf("wrong code returned; expected %d, but got %d", http.StatusCreated, rr.Code)
		}

		var res map[string]interface{}
		if err := json.Unmarshal(rr.Body.Bytes(), &res); err != nil {
			t.Errorf("failed to parse response body: %v", err)
		}

		if _, ok := res["token"]; !ok {
			t.Error("token not found in response")
		}
		if _, ok := res["user"]; !ok {
			t.Error("user not found in response")
		}
	})

	t.Run("duplicate username", func(t *testing.T) {
		repo := infrastructure.InjectUsersRepository(nil)
		authService := service.NewAuthService("test")
		createUserHandler := NewCreateUserHandler(repo, authService)

		initialUserBody, err := json.Marshal(openapi.CreateUserRequest{
			Username:    "test",
			DisplayName: "test",
			Password:    "securepassword",
		})
		if err != nil {
			t.Errorf("failed to marshal request body: %v", err)
		}
		initialUserReq := httptest.NewRequest("POST", "/api/users", bytes.NewReader(initialUserBody))
		initialUserRr := httptest.NewRecorder()

		createUserHandler.CreateUser(initialUserRr, initialUserReq)

		duplicateUserBody, err := json.Marshal(openapi.CreateUserRequest{
			Username:    "test",
			DisplayName: "duplicated",
			Password:    "securepassword",
		})
		if err != nil {
			t.Errorf("failed to marshal request body: %v", err)
		}
		duplicateUserReq := httptest.NewRequest("POST", "/api/users", bytes.NewReader(duplicateUserBody))
		duplicateUserRr := httptest.NewRecorder()

		createUserHandler.CreateUser(duplicateUserRr, duplicateUserReq)

		if duplicateUserRr.Code != http.StatusConflict {
			t.Errorf("wrong code returned; expected %d, but got %d", http.StatusConflict, duplicateUserRr.Code)
		}
	})
}

// TODO: Add error tests for authService after the fake implementation.
func TestCreateUser_Error(t *testing.T) {
	tests := map[string]struct {
		username     string
		displayName  string
		password     string
		expectedCode int
	}{
		"too short password": {
			username:     "test",
			displayName:  "test",
			password:     "shortpw",
			expectedCode: http.StatusBadRequest,
		},
		"too long password": {
			username:     "test",
			displayName:  "test",
			password:     "longsecurepassword",
			expectedCode: http.StatusBadRequest,
		},
	}
	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			repo := infrastructure.InjectUsersRepository(nil)
			authService := service.NewAuthService("test")
			createUserHandler := NewCreateUserHandler(repo, authService)

			body, err := json.Marshal(openapi.CreateUserRequest{
				DisplayName: tt.displayName,
				Password:    tt.password,
				Username:    tt.username,
			})
			if err != nil {
				t.Errorf("failed to marshal request body: %v", err)
			}
			req := httptest.NewRequest("POST", "/api/users", bytes.NewReader(body))
			rr := httptest.NewRecorder()
			createUserHandler.CreateUser(rr, req)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
