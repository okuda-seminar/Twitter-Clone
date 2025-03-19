package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"

	"x-clone-backend/internal/lib/featureflag"

	"github.com/google/uuid"
)

func (s *handlerTestSuite) TestCreateRepost() {
	userID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)
	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, userID))
	repostID := s.newTestQuoteRepost(userID, postID)

	tests := []struct {
		name         string
		userID       string
		body         string
		expectedCode int
	}{
		{
			name:         "create repost from a post",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "create repost from a quote repost",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, repostID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s }`, postID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			userID:       userID,
			body:         "{}",
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "non-existent user id",
			userID:       uuid.New().String(),
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "non-existent post id",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, uuid.New()),
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			fmt.Sprintf("/api/users/%s/reposts", test.userID),
			strings.NewReader(test.body),
		)
		rr := httptest.NewRecorder()

		createRepostHandler := NewCreateRepostHandler(s.db, &s.mu, &s.userChannels)
		createRepostHandler.CreateRepost(rr, req, test.userID)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}

func (s *handlerTestSuite) TestCreateRepost_UseNewSchema() {
	featureflag.ResetTimelineFeatureFlag()
	s.T().Setenv(featureflag.UseNewSchemaEnvKey, "true")
	s.T().Cleanup(func() {
		featureflag.ResetTimelineFeatureFlag()
	})
	userID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)
	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, userID))
	repostID := s.newTestQuoteRepost(userID, postID)

	tests := []struct {
		name         string
		userID       string
		body         string
		expectedCode int
	}{
		{
			name:         "create repost from a post",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "create repost from a quote repost",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, repostID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s }`, postID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			userID:       userID,
			body:         "{}",
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "non-existent user id",
			userID:       uuid.New().String(),
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "non-existent post id",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, uuid.New()),
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			fmt.Sprintf("/api/users/%s/reposts", test.userID),
			strings.NewReader(test.body),
		)
		rr := httptest.NewRecorder()

		createRepostHandler := NewCreateRepostHandler(s.db, &s.mu, &s.userChannels)
		createRepostHandler.CreateRepost(rr, req, test.userID)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}
