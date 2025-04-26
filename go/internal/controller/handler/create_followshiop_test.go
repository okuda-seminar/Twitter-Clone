package handler

import (
	"bytes"
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/google/uuid"

	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/fake"
	"x-clone-backend/internal/openapi"
)

func TestCreateFollowship(t *testing.T) {

	testUserID := uuid.New().String()
	targetUserID := uuid.New().String()

	tests := []struct {
		name         string
		body         interface{}
		setupRepo    func(repo repository.UsersRepository)
		expectedCode int
		expectedErr  error
	}{
		{
			name: "CreateFollowship successfully",
			body: openapi.CreateFollowshipRequest{
				TargetUserID: targetUserID,
			},
			setupRepo:    nil,
			expectedCode: http.StatusCreated,
			expectedErr:  nil,
		},
		{
			name: "UseCaseError",
			body: openapi.CreateFollowshipRequest{
				TargetUserID: targetUserID,
			},
			setupRepo: func(repo repository.UsersRepository) {
				repo.SetError("FollowUser", errors.New("usecase failure"))
			},
			expectedCode: http.StatusInternalServerError,
			expectedErr:  ErrCreateFollowship,
		},
	}

	for _, tt := range tests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			repo := fake.NewFakeUsersRepository()
			if tt.setupRepo != nil {
				tt.setupRepo(repo)
			}

			h := NewCreateFollowshipHandler(repo)

			var requestBody []byte
			if tt.body != nil {
				var err error
				requestBody, err = json.Marshal(tt.body)
				if err != nil {
					t.Fatalf("[%s] failed to marshal request body: %v", tt.name, err)
				}
			} else {
				requestBody = nil
			}

			req := httptest.NewRequest(http.MethodPost, "/api/users/{id}/following", bytes.NewReader(requestBody))
			rr := httptest.NewRecorder()

			h.CreateFollowship(rr, req, testUserID)

			if rr.Code != tt.expectedCode {
				t.Errorf("[%s] expected status %d; got %d", tt.name, tt.expectedCode, rr.Code)
			}

			gotBody := rr.Body.String()
			if tt.expectedErr != nil {
				expectedBody := tt.expectedErr.Error() + "\n"
				if gotBody != expectedBody {
					t.Errorf("[%s] expected body %q; got %q", tt.name, expectedBody, gotBody)
				}
			} else if strings.TrimSpace(gotBody) != "" {
				t.Errorf("[%s] expected empty body; got %q", tt.name, gotBody)
			}
		})
	}
}
