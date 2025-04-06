package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"

	"x-clone-backend/internal/application/service"
)

func createExpiredToken(userID uuid.UUID, username string) (string, error) {
	expiredClaims := service.UserClaims{
		Username: username,
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   userID.String(),
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(-time.Hour)),
			IssuedAt:  jwt.NewNumericDate(time.Now().Add(-2 * time.Hour)),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, expiredClaims)
	return token.SignedString("test_secret_key")
}

func (s *handlerTestSuite) TestVerifySessionHandler() {
	username := "testuser"
	displayName := "Test User"
	password := "securepassword"
	hashedPassword, _ := s.authService.HashPassword(password)
	createdUser, _ := s.createUserUsecase.CreateUser(username, displayName, hashedPassword)
	validToken, _ := s.authService.GenerateJWT(createdUser.ID, username)
	invalidToken := "invalid.token.string"
	nonExistentUserID := uuid.New()
	nonExistentUserToken, _ := s.authService.GenerateJWT(nonExistentUserID, "nonexistentuser")
	expiredToken, _ := createExpiredToken(createdUser.ID, username)

	tests := map[string]struct {
		authHeader     string
		expectedStatus int
		expectUserData bool
	}{
		"Valid Token": {
			authHeader:     fmt.Sprintf("Bearer %s", validToken),
			expectedStatus: http.StatusOK,
			expectUserData: true,
		},
		"Invalid Token Format": {
			authHeader:     fmt.Sprintf("Bearer %s", invalidToken),
			expectedStatus: http.StatusUnauthorized,
			expectUserData: false,
		},
		"Token with Non-existent User": {
			authHeader:     fmt.Sprintf("Bearer %s", nonExistentUserToken),
			expectedStatus: http.StatusInternalServerError,
			expectUserData: false,
		},
		"Expired Token": {
			authHeader:     fmt.Sprintf("Bearer %s", expiredToken),
			expectedStatus: http.StatusUnauthorized,
			expectUserData: false,
		},
		"Missing Authorization Header": {
			authHeader:     "",
			expectedStatus: http.StatusUnauthorized,
			expectUserData: false,
		},
		"Invalid Authorization Format": {
			authHeader:     validToken,
			expectedStatus: http.StatusUnauthorized,
			expectUserData: false,
		},
	}

	for name, tt := range tests {
		s.T().Run(name, func(t *testing.T) {
			verifySessionHandler := NewVerifySessionHandler(s.db, s.authService)
			req := httptest.NewRequest(http.MethodGet, "/api/session/verify", nil)
			req.Header.Set("Content-Type", "application/json")
			if tt.authHeader != "" {
				req.Header.Set("Authorization", tt.authHeader)
			}

			rr := httptest.NewRecorder()
			verifySessionHandler.VerifySession(rr, req)

			if rr.Code != tt.expectedStatus {
				t.Errorf("%s: expected status %d, got %d", name, tt.expectedStatus, rr.Code)
			}

			if tt.expectUserData && rr.Body.Len() == 0 {
				t.Errorf("%s: expected response body to contain user data but got empty body", name)
			}
		})
	}
}
