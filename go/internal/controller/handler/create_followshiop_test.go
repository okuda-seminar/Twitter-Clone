package handler

import (
	"bytes"
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/fake"
	"x-clone-backend/internal/openapi"
)

func TestCreateFollowship(t *testing.T) {
	testUserID := uuid.New().String()
	targetUserID := uuid.New().String()

	tests := map[string]struct {
		body         interface{}
		setupRepo    func(repo repository.UsersRepository)
		expectedCode int
	}{
		"CreateFollowship successfully": {
			body: openapi.CreateFollowshipRequest{
				TargetUserID: targetUserID,
			},
			setupRepo:    nil,
			expectedCode: http.StatusCreated,
		},
		"UseCaseError": {
			body: openapi.CreateFollowshipRequest{
				TargetUserID: targetUserID,
			},
			setupRepo: func(repo repository.UsersRepository) {
				repo.SetError("FollowUser", errors.New("usecase failure"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		name, tt := name, tt
		t.Run(name, func(t *testing.T) {
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
					t.Fatalf("[%s] failed to marshal request body: %v", name, err)
				}
			}

			req := httptest.NewRequest(http.MethodPost, "/api/users/{id}/following", bytes.NewReader(requestBody))
			rr := httptest.NewRecorder()

			h.CreateFollowship(rr, req, testUserID)

			if rr.Code != tt.expectedCode {
				t.Errorf("[%s] expected status %d; got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
