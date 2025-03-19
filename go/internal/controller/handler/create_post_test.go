package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"

	"x-clone-backend/internal/lib/featureflag"

	"github.com/google/uuid"
)

func (s *handlerTestSuite) TestCreatePost() {
	userID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)

	tests := []struct {
		name         string
		userID       string
		body         string
		expectedCode int
	}{
		{
			name:         "create post",
			body:         fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, userID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			body:         fmt.Sprintf(`{ "user_id": "%s, "text": "test" }`, userID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			body:         `{ "text": "test" }`,
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "non-existent user id",
			body:         fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, uuid.New().String()),
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			"/api/posts/",
			strings.NewReader(test.body),
		)
		rr := httptest.NewRecorder()

		createPostHandler := NewCreatePostHandler(s.db, &s.mu, &s.userChannels)
		createPostHandler.CreatePost(rr, req)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}

func (s *handlerTestSuite) TestCreatePost_UseNewSchema() {
	featureflag.ResetTimelineFeatureFlag()
	s.T().Setenv(featureflag.UseNewSchemaEnvKey, "true")
	s.T().Cleanup(func() {
		featureflag.ResetTimelineFeatureFlag()
	})
	userID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)

	tests := []struct {
		name         string
		body         string
		expectedCode int
	}{
		{
			name:         "create post",
			body:         fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, userID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			body:         fmt.Sprintf(`{ "user_id": "%s, "text": "test" }`, userID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			body:         `{ "text": "test" }`,
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "non-existent user id",
			body:         fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, uuid.New().String()),
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			"/api/posts/",
			strings.NewReader(test.body),
		)
		rr := httptest.NewRecorder()

		createPostHandler := NewCreatePostHandler(s.db, &s.mu, &s.userChannels)
		createPostHandler.CreatePost(rr, req)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}
