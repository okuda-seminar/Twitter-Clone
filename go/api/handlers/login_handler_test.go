package handlers

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

// TestLoginHandler tests the login functionality using HandlersTestSuite
func (s *HandlersTestSuite) TestLoginHandler() {
	username := "testuser"
	password := "securepassword"
	hashedPassword, _ := s.authService.HashPassword(password)
	s.createUserUsecase.CreateUser(username, "Test User", hashedPassword)

	tests := map[string]struct {
		requestBody    map[string]string
		expectedStatus int
		expectToken    bool
	}{
		"Valid Login": {
			requestBody:    map[string]string{"username": username, "password": password},
			expectedStatus: http.StatusOK,
			expectToken:    true,
		},
		"Invalid Username": {
			requestBody:    map[string]string{"username": "wronguser", "password": password},
			expectedStatus: http.StatusNotFound,
			expectToken:    false,
		},
		"Invalid Password": {
			requestBody:    map[string]string{"username": username, "password": "wrongpassword"},
			expectedStatus: http.StatusUnauthorized,
			expectToken:    false,
		},
		"Invalid JSON Format": {
			requestBody:    map[string]string{"username": ""},
			expectedStatus: http.StatusBadRequest,
			expectToken:    false,
		},
	}

	for name, tt := range tests {
		loginHandler := NewLoginHandler(s.db, s.authService)
		s.T().Run(name, func(t *testing.T) {
			reqBody, _ := json.Marshal(tt.requestBody)
			req := httptest.NewRequest(http.MethodPost, "/api/login", bytes.NewBuffer(reqBody))
			req.Header.Set("Content-Type", "application/json")

			rr := httptest.NewRecorder()
			loginHandler.Login(rr, req)

			if rr.Code != tt.expectedStatus {
				t.Errorf("%s: expected status %d, got %d", name, tt.expectedStatus, rr.Code)
			}

			if tt.expectToken && rr.Body.Len() == 0 {
				t.Errorf("%s: expected response body to contain a token but got empty body", name)
			}
		})
	}
}
