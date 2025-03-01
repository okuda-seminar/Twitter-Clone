package handlers

import (
	"encoding/json"
	"fmt"
	"net/http/httptest"
	"strings"
	"x-clone-backend/internal/domain/entities"
)

func (s *HandlersTestSuite) TestGetUserPostsTimeline() {
	// This test method verifies the number of posts in the response body.
	user1ID := s.newTestUser(`{ "username": "test1", "display_name": "test1", "password": "securepassword" }`)
	_ = s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test1" }`, user1ID))
	user2ID := s.newTestUser(`{ "username": "test2", "display_name": "test2", "password": "securepassword" }`)

	tests := []struct {
		name          string
		userID        string
		expectedCount int
	}{
		{
			name:          "get user posts",
			userID:        user1ID,
			expectedCount: 1,
		},
		{
			name:          "get no posts",
			userID:        user2ID,
			expectedCount: 0,
		},
	}

	for _, test := range tests {
		rr := httptest.NewRecorder()
		req := httptest.NewRequest(
			"GET",
			"/api/users/{id}/posts",
			strings.NewReader(""),
		)
		req.SetPathValue("id", test.userID)

		getUserPostsTimelineHandler := NewGetUserPostsTimelineHandler(s.db)
		getUserPostsTimelineHandler.GetUserPostsTimeline(rr, req, test.userID)

		var posts []*entities.Post

		decoder := json.NewDecoder(rr.Body)
		err := decoder.Decode(&posts)
		if err != nil {
			s.T().Errorf("%s: failed to decode response", test.name)
		}

		if len(posts) != test.expectedCount {
			s.T().Errorf("%s: wrong number of posts returned; expected %d, but got %d", test.name, test.expectedCount, len(posts))
		}
	}
}
