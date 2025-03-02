package middlewares

import (
	"net/http"
	"net/http/httptest"
	"testing"
	"x-clone-backend/internal/app/services"

	"github.com/google/uuid"
)

// TestJWTMiddleware tests the JWTMiddleware function by verifying
// that a valid JWT token allows access, an invalid token denies access,
// and requests with missing or invalid Authorization headers are rejected.
func TestJWTMiddleware(t *testing.T) {
	secretKey := "test_secret_key"
	authService := services.NewAuthService(secretKey)

	tokenString, _ := authService.GenerateJWT(uuid.New(), "test_user")

	testHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		claims, ok := r.Context().Value(UserContextKey).(*services.UserClaims)
		if !ok {
			t.Error("Failed to retrieve claims from context")
			http.Error(w, "Unauthorized", http.StatusUnauthorized)
			return
		}

		if claims.Username != "test_user" {
			t.Errorf("Expected username 'test_user', got '%v'", claims.Username)
		}

		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Success"))
	})

	handlerToTest := JWTMiddleware(authService)(testHandler)

	// Test case 1: Valid token
	req1 := httptest.NewRequest("GET", "/", nil)
	req1.Header.Set("Authorization", "Bearer "+tokenString)
	rr1 := httptest.NewRecorder()

	handlerToTest.ServeHTTP(rr1, req1)

	if status := rr1.Code; status != http.StatusOK {
		t.Errorf("Handler returned wrong status code: got %v want %v", status, http.StatusOK)
	}

	if rr1.Body.String() != "Success" {
		t.Errorf("Handler returned unexpected body: got %v want %v", rr1.Body.String(), "Success")
	}

	// Test case 2: Invalid token
	req2 := httptest.NewRequest("GET", "/", nil)
	req2.Header.Set("Authorization", "Bearer invalidtoken")
	rr2 := httptest.NewRecorder()

	handlerToTest.ServeHTTP(rr2, req2)

	if status := rr2.Code; status != http.StatusUnauthorized {
		t.Errorf("Handler returned wrong status code for invalid token: got %v want %v", status, http.StatusUnauthorized)
	}

	// Test case 3: Missing Authorization header
	req3 := httptest.NewRequest("GET", "/", nil)
	rr3 := httptest.NewRecorder()

	handlerToTest.ServeHTTP(rr3, req3)

	if status := rr3.Code; status != http.StatusUnauthorized {
		t.Errorf("Handler returned wrong status code for missing header: got %v want %v", status, http.StatusUnauthorized)
	}
}
