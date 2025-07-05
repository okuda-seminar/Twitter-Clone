package handler

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"

	"x-clone-backend/internal/application/service"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/entity"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
	"x-clone-backend/internal/openapi"
)

func TestVerifySessionHandler(t *testing.T) {
	t.Run("Valid Token", func(t *testing.T) {
		usersRepository := infraInjector.InjectUsersRepository(nil)
		authService := service.NewAuthService("test_secret_key")
		userByUserIDUsecase := usecaseInjector.InjectUserByUserIDUsecase(usersRepository)
		verifySessionHandler := NewVerifySessionHandler(authService, userByUserIDUsecase)

		// Fixture
		username := "testuser"
		password := "securepassword"

		hashedPassword, _ := authService.HashPassword(password)
		user := entity.User{
			ID:          uuid.NewString(),
			Username:    "test user",
			Password:    hashedPassword,
			DisplayName: "test user",
			Bio:         "test bio",
			IsPrivate:   false,
			CreatedAt:   time.Now(),
			UpdatedAt:   time.Now(),
		}
		userByUserIDUsecase.SetUser(user)

		token, _ := authService.GenerateJWT(user.ID, username)

		req := httptest.NewRequest(http.MethodGet, "/api/session/verify", nil)
		req.Header.Set("Content-Type", "application/json")
		req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", token))

		rr := httptest.NewRecorder()
		verifySessionHandler.VerifySession(rr, req)

		if rr.Code != http.StatusOK {
			t.Errorf("expected status %d, got %d", http.StatusOK, rr.Code)
		}

		var resp openapi.VerifySessionResponse
		err := json.Unmarshal(rr.Body.Bytes(), &resp)
		if err != nil {
			t.Fatalf("Failed to unmarshal response body: %v", err)
		}
		if resp.User.Id != user.ID {
			t.Errorf("expected user ID %s, got %s", user.ID, resp.User.Id)
		}
	})

	t.Run("Token With Non-Existent User", func(t *testing.T) {
		usersRepository := infraInjector.InjectUsersRepository(nil)
		authService := service.NewAuthService("test_secret_key")
		userByUserIDUsecase := usecaseInjector.InjectUserByUserIDUsecase(usersRepository)
		verifySessionHandler := NewVerifySessionHandler(authService, userByUserIDUsecase)

		userByUserIDUsecase.SetError(errors.New("User not found"))

		token, _ := authService.GenerateJWT(uuid.NewString(), "nonexistentuser")

		req := httptest.NewRequest(http.MethodGet, "/api/session/verify", nil)
		req.Header.Set("Content-Type", "application/json")
		req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", token))

		rr := httptest.NewRecorder()
		verifySessionHandler.VerifySession(rr, req)

		if rr.Code != http.StatusInternalServerError {
			t.Errorf("expected status %d, got %d", http.StatusInternalServerError, rr.Code)
		}
	})

	t.Run("Expired Token", func(t *testing.T) {
		usersRepository := infraInjector.InjectUsersRepository(nil)
		authService := service.NewAuthService("test_secret_key")
		userByUserIDUsecase := usecaseInjector.InjectUserByUserIDUsecase(usersRepository)
		verifySessionHandler := NewVerifySessionHandler(authService, userByUserIDUsecase)

		token, _ := createExpiredToken(uuid.NewString(), "testuser")

		req := httptest.NewRequest(http.MethodGet, "/api/session/verify", nil)
		req.Header.Set("Content-Type", "application/json")
		req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", token))

		rr := httptest.NewRecorder()
		verifySessionHandler.VerifySession(rr, req)

		if rr.Code != http.StatusUnauthorized {
			t.Errorf("expected status %d, got %d", http.StatusUnauthorized, rr.Code)
		}
	})
}

func createExpiredToken(userID string, username string) (string, error) {
	expiredClaims := service.UserClaims{
		Username: username,
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   userID,
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(-time.Hour)),
			IssuedAt:  jwt.NewNumericDate(time.Now().Add(-2 * time.Hour)),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, expiredClaims)
	return token.SignedString("test_secret_key")
}
