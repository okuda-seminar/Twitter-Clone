package middleware

import (
	"context"
	"net/http"

	"x-clone-backend/internal/application/service"
)

type key int

const (
	// UserContextKey is the key used to store user ID in the context
	UserContextKey key = iota
)

// JWTMiddleware is a middleware function that validates JWT tokens.
// It extracts the token from the Authorization header, validates it,
// and stores the user ID in the request context for downstream handler.
func JWTMiddleware(s *service.AuthService) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			authToken, err := service.ExtractTokenFromHeader(r)
			if err != nil {
				http.Error(w, err.Error(), http.StatusUnauthorized)
				return
			}

			userID, err := s.ValidateJWT(authToken)
			if err != nil {
				http.Error(w, "Invalid token: "+err.Error(), http.StatusUnauthorized)
				return
			}

			ctx := context.WithValue(r.Context(), UserContextKey, userID)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}
