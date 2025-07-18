package service

import (
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

const (
	minPasswordLength = 8
	maxPasswordLength = 15

	// Token expiration times
	jwtExpirationDuration = time.Hour * 1 // Token expires after 1 hour
)

type AuthService struct {
	secretKey []byte
	logger    *slog.Logger
}

func NewAuthService(secretKey string) *AuthService {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	return &AuthService{secretKey: []byte(secretKey), logger: logger}
}

// UserClaims represents custom claims for JWT tokens.
type UserClaims struct {
	Username string `json:"username"`
	jwt.RegisteredClaims
}

func ExtractTokenFromHeader(r *http.Request) (string, error) {
	authHeader := r.Header.Get("Authorization")
	if authHeader == "" {
		return "", fmt.Errorf("authorization header missing.")
	}

	parts := strings.Split(authHeader, " ")
	if len(parts) != 2 || strings.ToLower(parts[0]) != "bearer" {
		return "", fmt.Errorf("invalid authorization header format.")
	}

	return parts[1], nil
}

// GenerateJWT generates a JWT with user ID and username
func (s *AuthService) GenerateJWT(userID string, username string) (string, error) {
	// Set payload (claims)
	claims := UserClaims{
		Username: username,
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   userID,
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(jwtExpirationDuration)),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
		},
	}

	// Set header & payload
	unsignedToken := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	// Sign the JWT
	signedToken, err := unsignedToken.SignedString(s.secretKey)
	if err != nil {
		s.logger.Error("Failed to sign JWT", "error", err)
		return "", err
	}

	// Log the generated JWT
	s.logger.Info("Successfully generated JWT", "JWT", signedToken)
	return signedToken, nil
}

// ValidateJWT verifies and extracts claims from a JWT.
func (s *AuthService) ValidateJWT(tokenString string) (string, error) {
	// Parse the JWT token and verify its signature and expiration time.
	token, err := jwt.ParseWithClaims(tokenString, &UserClaims{}, func(t *jwt.Token) (interface{}, error) {
		return s.secretKey, nil
	})

	// Handle errors
	if err != nil || !token.Valid {
		s.logger.Error("Invalid or expired token", "error", err)
		return "", fmt.Errorf("Invalid or expired token")
	}

	claims, ok := token.Claims.(*UserClaims)
	if !ok {
		s.logger.Error("Failed to parse claims from JWT token", "token", tokenString)
		return "", fmt.Errorf("failed to parse claims")
	}

	userID := claims.Subject
	s.logger.Info("Token validated successfully", "userID", userID)
	return userID, nil
}

// HashPassword hashes a given password using bcrypt
func (s *AuthService) HashPassword(password string) (string, error) {
	hashed, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", err
	}
	return string(hashed), nil
}

// ValidatePassword checks the password length requirements
func (s *AuthService) ValidatePassword(password string) error {
	if len(password) < minPasswordLength || len(password) > maxPasswordLength {
		return fmt.Errorf("password must be between %d and %d characters", minPasswordLength, maxPasswordLength)
	}
	return nil
}

// VerifyPassword checks if the given password matches the hashed password
func (s *AuthService) VerifyPassword(hashedPassword, password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
	return err == nil
}
