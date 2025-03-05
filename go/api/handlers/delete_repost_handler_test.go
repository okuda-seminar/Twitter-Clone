package handlers

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
)

func (s *HandlersTestSuite) TestDeleteRepost() {
	userID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)
	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test" }`, userID))
	repostID := s.newTestRepost(userID, postID)
	quoteRepostID := s.newTestQuoteRepost(userID, postID)

	tests := []struct {
		name         string
		parentID     string
		body         string
		expectedCode int
	}{
		{
			name:         "delete repost",
			parentID:     postID,
			body:         fmt.Sprintf(`{ "repost_id": "%s" }`, repostID),
			expectedCode: http.StatusNoContent,
		},
		{
			name:         "delete quote repost",
			parentID:     repostID,
			body:         fmt.Sprintf(`{ "repost_id": "%s" }`, quoteRepostID),
			expectedCode: http.StatusNoContent,
		},
		{
			name:         "non-existent repost",
			parentID:     postID,
			body:         fmt.Sprintf(`{ "repost_id": "%s" }`, repostID),
			expectedCode: http.StatusNotFound,
		},
	}

	for _, test := range tests {
		rr := httptest.NewRecorder()
		req := httptest.NewRequest(
			"DELETE",
			fmt.Sprintf("/api/users/%s/reposts/%s", userID, test.parentID),
			strings.NewReader(test.body),
		)
		req.SetPathValue("user_id", userID)
		req.SetPathValue("post_id", test.parentID)

		deleteRepostHandler := NewDeleteRepostHandler(s.db, &s.mu, &s.userChannels)
		deleteRepostHandler.DeleteRepost(rr, req, userID, test.parentID)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}
