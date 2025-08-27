package service

import (
	"testing"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

// TestGenerateJWT tests the JWT generation functionality of AuthService.
func TestGenerateJWT(t *testing.T) {
	secretKey := "test_secret_key"
	authService := NewAuthService(secretKey)

	userID := uuid.NewString()
	username := "test_user"

	signedToken, err := authService.GenerateJWT(userID, username)

	if err != nil {
		t.Fatalf("Expected no error, but got: %v", err)
	}
	if signedToken == "" {
		t.Fatalf("Expected a valid token, but got an empty string")
	}
}

// TestValidateJWT tests the validation of a valid JWT in AuthService.
func TestValidateJWT(t *testing.T) {
	secretKey := "test_secret_key"
	authService := NewAuthService(secretKey)

	userID := uuid.NewString()
	username := "test_user"

	signedToken, err := authService.GenerateJWT(userID, username)
	if err != nil {
		t.Fatalf("Expected no error, but got: %v", err)
	}

	extractedUserID, err := authService.ValidateJWT(signedToken)
	if err != nil {
		t.Fatalf("Expected no error, but got: %v", err)
	}

	if extractedUserID != userID {
		t.Errorf("Expected user ID %v, but got %v", userID, extractedUserID)
	}
}

// TestExpiredJWT tests the validation of an expired JWT.
func TestExpiredJWT(t *testing.T) {
	secretKey := "test_secret_key"
	authService := NewAuthService(secretKey)

	expiredToken := generateExpiredJWT(secretKey)

	_, err := authService.ValidateJWT(expiredToken)
	if err == nil {
		t.Errorf("Expected error for expired token, but got nil")
	}
}

// TestInvalidSignatureJWT tests the validation of a JWT with an invalid signature.
func TestInvalidSignatureJWT(t *testing.T) {
	secretKey := "test_secret_key"
	authService := NewAuthService(secretKey)

	userID := uuid.NewString()
	username := "test_user"

	_, err := authService.GenerateJWT(userID, username)
	if err != nil {
		t.Fatalf("Expected no error, but got: %v", err)
	}

	otherKey := "another_secret_key"
	otherAuthService := NewAuthService(otherKey)
	invalidToken, err := otherAuthService.GenerateJWT(userID, username)
	if err != nil {
		t.Fatalf("Expected no error, but got: %v", err)
	}

	_, err = authService.ValidateJWT(invalidToken)
	if err == nil {
		t.Errorf("Expected error for invalid signature, but got nil")
	}
}

// generateExpiredJWT generates an expired JWT for testing purposes.
func generateExpiredJWT(secretKey string) string {
	claims := UserClaims{
		Username: "test_user",
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   uuid.NewString(),
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(-time.Hour)),
			IssuedAt:  jwt.NewNumericDate(time.Now().Add(-2 * time.Hour)),
		},
	}

	unsignedToken := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signedToken, _ := unsignedToken.SignedString([]byte(secretKey))
	return signedToken
}
