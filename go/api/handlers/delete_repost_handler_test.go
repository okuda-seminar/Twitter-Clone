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
	s.newTestRepost(userID, postID)

	tests := []struct {
		name         string
		expectedCode int
	}{
		{
			name:         "delete repost",
			expectedCode: http.StatusNoContent,
		},
		{
			name:         "non-existent repost",
			expectedCode: http.StatusNotFound,
		},
	}

	for _, test := range tests {
		rr := httptest.NewRecorder()
		req := httptest.NewRequest(
			"DELETE",
			"/api/posts/reposts/{user_id}/{post_id}",
			strings.NewReader(""),
		)
		req.SetPathValue("user_id", userID)
		req.SetPathValue("post_id", postID)

		deleteRepostHandler := NewDeleteRepostHandler(s.db, &s.mu, &s.userChannels)
		deleteRepostHandler.DeleteRepost(rr, req, userID, postID)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}
