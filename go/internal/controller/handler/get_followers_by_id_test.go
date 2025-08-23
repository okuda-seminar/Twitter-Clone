package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"
)

func TestGetFollowersByID(t *testing.T) {
	userID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		expectedCode int
	}{
		"returns 200 for any user ID": {
			userID:       userID,
			expectedCode: http.StatusOK,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			getFollowersByIDHandler := NewGetFollowersByIDHandler()

			req := httptest.NewRequest(
				"GET",
				fmt.Sprintf("/api/users/%s/followers", tt.userID),
				nil,
			)
			rr := httptest.NewRecorder()

			getFollowersByIDHandler.GetFollowersByID(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
