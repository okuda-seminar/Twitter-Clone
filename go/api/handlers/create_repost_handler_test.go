package handlers

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"

	"github.com/google/uuid"
)

func (s *HandlersTestSuite) TestCreateRepost() {
	userID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)
	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, userID))

	tests := []struct {
		name         string
		body         string
		expectedCode int
	}{
		{
			name:         "create repost",
			body:         fmt.Sprintf(`{ "post_id": "%s", "user_id": "%s" }`, postID, userID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			body:         fmt.Sprintf(`{ "post_id": "%s", "user_id": "%s }`, postID, userID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "non-existent user id",
			body:         fmt.Sprintf(`{ "post_id": "%s", "user_id": "%s" }`, postID, uuid.New()),
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "non-existent post id",
			body:         fmt.Sprintf(`{ "post_id": "%s", "user_id": "%s" }`, uuid.New(), userID),
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "duplicated repost",
			body:         fmt.Sprintf(`{ "post_id": "%s", "user_id": "%s" }`, postID, userID),
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			"/api/posts/reposts",
			strings.NewReader(test.body),
		)
		rr := httptest.NewRecorder()

		createRepostHandler := NewCreateRepostHandler(s.db, &s.mu, &s.userChannels)
		createRepostHandler.CreateRepost(rr, req)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}
