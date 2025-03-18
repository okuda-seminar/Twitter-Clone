package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"

	"github.com/google/uuid"
)

func (s *handlerTestSuite) TestCreateQuoteRepost() {
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
			name:         "create quote repost from a post",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s", "text": "test" }`, postID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "create quote repost from a quote repost",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s", "text": "test" }`, repostID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s, "text": "test" }`, postID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			userID:       userID,
			body:         `{"text": "test"}`,
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "non-existent user id",
			userID:       uuid.New().String(),
			body:         fmt.Sprintf(`{ "post_id": "%s", "text": "test" }`, postID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "non-existent post id",
			userID:       userID,
			body:         fmt.Sprintf(`{ "post_id": "%s", "text": "test" }`, uuid.New()),
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			fmt.Sprintf("/api/users/%s/quote_reposts", test.userID),
			strings.NewReader(test.body),
		)
		rr := httptest.NewRecorder()

		createRepostHandler := NewCreateQuoteRepostHandler(s.db, &s.mu, &s.userChannels)
		createRepostHandler.CreateQuoteRepost(rr, req, test.userID)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}
