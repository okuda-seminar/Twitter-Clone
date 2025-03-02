package middlewares

import (
	"context"
	"net/http"
	"strings"
	"x-clone-backend/internal/app/services"
)

type key int

const (
	// UserContextKey is the key used to store user information in the context
	UserContextKey key = iota
)

// JWTMiddleware is a middleware function that validates JWT tokens.
// It extracts the token from the Authorization header, validates it,
// and stores the user claims in the request context for downstream handlers.
func JWTMiddleware(s *services.AuthService) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			authHeader := r.Header.Get("Authorization")
			if authHeader == "" {
				http.Error(w, "Authorization header missing", http.StatusUnauthorized)
				return
			}

			parts := strings.Split(authHeader, " ")
			if len(parts) != 2 || strings.ToLower(parts[0]) != "bearer" {
				http.Error(w, "Invalid authorization header format", http.StatusUnauthorized)
				return
			}
			authToken := parts[1]

			claims, err := s.ValidateJWT(authToken)
			if err != nil {
				http.Error(w, "Invalid token: "+err.Error(), http.StatusUnauthorized)
				return
			}

			ctx := context.WithValue(r.Context(), UserContextKey, claims)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}
