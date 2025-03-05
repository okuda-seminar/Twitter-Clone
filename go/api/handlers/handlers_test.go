package handlers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"x-clone-backend/internal/domain/entities"

	"github.com/google/uuid"
	"github.com/stretchr/testify/suite"
)

func (s *HandlersTestSuite) TestDeletePost() {
	userID := s.newTestUser(`{ "username": "test user", "display_name": "test user", "password": "securepassword" }`)
	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test post" }`, userID))

	tests := []struct {
		name         string
		postID       string
		expectedCode int
	}{
		{
			name:         "delete a post successfully with a proper post ID.",
			postID:       postID,
			expectedCode: http.StatusNoContent,
		},
		{
			name:         "fail to delete a post that was already deleted .",
			postID:       postID,
			expectedCode: http.StatusNotFound,
		},
		{
			name:         "fail to delete a post with a non-existent post ID.",
			postID:       uuid.New().String(),
			expectedCode: http.StatusNotFound,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest("DELETE", "/api/posts{postID}",
			nil)
		req.SetPathValue("postID", test.postID)

		rr := httptest.NewRecorder()
		DeletePost(rr, req, s.db, &s.mu, &s.userChannels)

		if rr.Code != test.expectedCode {
			s.T().Errorf(
				"%s: wrong code returned; expected %d, but got %d",
				test.name,
				test.expectedCode,
				rr.Code,
			)
		}
	}
}

func (s *HandlersTestSuite) TestLikePost() {
	// LikePost must use existing user ID and post ID
	// from the users and posts table.
	// Therefore, users and posts are created
	// for testing purposes to obtain these IDs.
	authorUserID := s.newTestUser(`{ "username": "author", "display_name": "author", "password": "securepassword" }`)
	likerUserID := s.newTestUser(`{ "username": "liker", "display_name": "liker", "password": "securepassword" }`)
	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test post" }`, authorUserID))

	tests := []struct {
		name         string
		userID       string
		body         string
		expectedCode int
	}{
		{
			name:         "like an own post successfully with a proper pair of User and Post",
			userID:       authorUserID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "like another user's post successfully with a proper pair of User and Post",
			userID:       likerUserID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusCreated,
		},
		{
			name:         "fail to like another user's post with a invalid JSON body",
			userID:       likerUserID,
			body:         fmt.Sprintf(`{ "post_id": "%s"`, postID),
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "fail to like a post with a invalid JSON field",
			userID:       likerUserID,
			body:         `{ "invalid": "test" }`,
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "fail to like a post with a pair of non-existent User and proper Post",
			userID:       uuid.New().String(),
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "fail to like a post with a pair of proper User and non-existent Post",
			userID:       likerUserID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, uuid.New().String()),
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "fail to like another user's post duplicately with a proper pair of User and Post",
			userID:       likerUserID,
			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			"/api/users/{id}/likes",
			strings.NewReader(test.body),
		)
		req.SetPathValue("id", test.userID)

		rr := httptest.NewRecorder()
		LikePost(rr, req, s.likePostUsecase)

		if rr.Code != test.expectedCode {
			s.T().Errorf(
				"%s: wrong code returned; expected %d, but got %d",
				test.name,
				test.expectedCode,
				rr.Code,
			)
		}
	}
}

func (s *HandlersTestSuite) TestUnlikePost() {
	// UnlikePost must use existing user ID and post ID
	// from the users and posts table.
	// Therefore, users and posts are created
	// for testing purposes to obtain these IDs.
	userID := s.newTestUser(`{ "username": "user", "display_name": "user", "password": "securepassword" }`)
	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test post" }`, userID))
	s.newTestLike(userID, postID)

	tests := []struct {
		name         string
		userID       string
		postID       string
		expectedCode int
	}{
		{
			name:         "unlike a post successfully with a proper pair of User and Post.",
			userID:       userID,
			postID:       postID,
			expectedCode: http.StatusNoContent,
		},
		{
			name:         "fail to unlike a post with a pair of non-existent User and proper Post.",
			userID:       uuid.New().String(),
			postID:       postID,
			expectedCode: http.StatusNotFound,
		},
		{
			name:         "fail to unlike a post with a pair of proper User and non-existent Post.",
			userID:       userID,
			postID:       uuid.New().String(),
			expectedCode: http.StatusNotFound,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"DELETE",
			"/api/users/{id}/likes/{post_id}",
			strings.NewReader(""),
		)
		req.SetPathValue("id", test.userID)
		req.SetPathValue("post_id", test.postID)

		rr := httptest.NewRecorder()
		UnlikePost(rr, req, s.unlikePostUsecase)

		if rr.Code != test.expectedCode {
			s.T().Errorf(
				"%s: wrong code returned; expected %d, but got %d",
				test.name,
				test.expectedCode,
				rr.Code,
			)
		}

	}
}

func (s *HandlersTestSuite) TestCreateMuting() {
	// CreateMuting must use existing user IDs from the user table
	// for both the source user ID and target user ID.
	// Therefore, users are created for testing purposes to obtain these IDs.
	sourceUserID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)
	targetUserID := s.newTestUser(`{ "username": "test2", "display_name": "test2", "password": "securepassword" }`)

	tests := []struct {
		name         string
		body         string
		expectedCode int
	}{
		{
			name:         "create muting",
			body:         `{ "target_user_id": "` + targetUserID + `" }`,
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			body:         `{ "target_user_id": "` + targetUserID,
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			body:         `{ "invalid": "test" }`,
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "duplicated muting",
			body:         `{ "target_user_id": "` + targetUserID + `" }`,
			expectedCode: http.StatusInternalServerError,
		},
	}

	for _, test := range tests {
		req := httptest.NewRequest(
			"POST",
			"/api/users/{id}/muting",
			strings.NewReader(test.body),
		)
		req.SetPathValue("id", sourceUserID)

		rr := httptest.NewRecorder()
		CreateMuting(rr, req, s.muteUserUsecase)

		if rr.Code != test.expectedCode {
			s.T().Errorf(
				"%s: wrong code returned; expected %d, but got %d",
				test.name,
				test.expectedCode,
				rr.Code,
			)
		}
	}
}

func (s *HandlersTestSuite) newTestRepost(userID, postID string) string {
	req := httptest.NewRequest(
		"POST",
		fmt.Sprintf("/api/users/%s/reposts", userID),
		strings.NewReader(fmt.Sprintf(`{ "post_id": "%s" }`, postID)),
	)
	rr := httptest.NewRecorder()

	createRepostHandler := NewCreateRepostHandler(s.db, &s.mu, &s.userChannels)
	createRepostHandler.CreateRepost(rr, req, userID)

	var repost entities.Repost
	_ = json.NewDecoder(rr.Body).Decode(&repost)
	repostID := repost.ID.String()
	return repostID
}

func (s *HandlersTestSuite) newTestDeleteRepost(userID string, postID string, repostID string) {
	req := httptest.NewRequest(
		"DELETE",
		fmt.Sprintf("/api/users/%s/reposts/%s", userID, postID),
		strings.NewReader(fmt.Sprintf(`{ "repost_id": "%s" }`, repostID)),
	)

	rr := httptest.NewRecorder()

	deleteRepostHandler := NewDeleteRepostHandler(s.db, &s.mu, &s.userChannels)
	deleteRepostHandler.DeleteRepost(rr, req, userID, postID)
}

func (s *HandlersTestSuite) newTestQuoteRepost(userID, postID string) string {
	req := httptest.NewRequest(
		"POST",
		fmt.Sprintf("/api/users/%s/quote_reposts", userID),
		strings.NewReader(fmt.Sprintf(`{ "post_id": "%s", "text": "test" }`, postID)),
	)
	rr := httptest.NewRecorder()

	createRepostHandler := NewCreateQuoteRepostHandler(s.db, &s.mu, &s.userChannels)
	createRepostHandler.CreateQuoteRepost(rr, req, userID)

	var repost entities.Repost
	_ = json.NewDecoder(rr.Body).Decode(&repost)
	repostID := repost.ID.String()
	return repostID
}

func (s *HandlersTestSuite) newTestUser(body string) string {
	req := httptest.NewRequest(
		"POST",
		"/api/users",
		strings.NewReader(body),
	)
	rr := httptest.NewRecorder()

	createUserHandler := NewCreateUserHandler(s.db, s.authService)
	createUserHandler.CreateUser(rr, req)

	var res map[string]interface{}

	err := json.NewDecoder(rr.Body).Decode(&res)
	if err != nil {
		s.T().Fatalf("Failed to decode response: %v", err)
	}

	sourceUserData, ok := res["user"].(map[string]interface{})
	if !ok {
		s.T().Fatalf("Invalid response format: 'user' key not found or invalid")
	}

	sourceUserID, ok := sourceUserData["id"].(string)
	if !ok {
		s.T().Fatalf("Invalid response format: 'id' key not found or invalid")
	}

	return sourceUserID
}

func (s *HandlersTestSuite) newTestDeletePost(postID string) {
	req := httptest.NewRequest("DELETE", "/api/posts{postID}", nil)
	req.SetPathValue("postID", postID)

	rr := httptest.NewRecorder()
	DeletePost(rr, req, s.db, &s.mu, &s.userChannels)
}

func (s *HandlersTestSuite) newTestPost(body string) string {
	req := httptest.NewRequest(
		"POST",
		"/api/posts",
		strings.NewReader(body),
	)
	rr := httptest.NewRecorder()

	createPostHandler := NewCreatePostHandler(s.db, &s.mu, &s.userChannels)
	createPostHandler.CreatePost(rr, req)

	var post entities.Post
	_ = json.NewDecoder(rr.Body).Decode(&post)
	postID := post.ID.String()
	return postID
}

func (s *HandlersTestSuite) newTestLike(userID string, postID string) {
	req := httptest.NewRequest(
		"POST",
		"/api/users/{id}/likes",
		strings.NewReader(fmt.Sprintf(`{ "post_id": "%s" }`, postID)),
	)
	req.SetPathValue("id", userID)

	rr := httptest.NewRecorder()
	LikePost(rr, req, s.likePostUsecase)
}

func (s *HandlersTestSuite) newTestFollow(sourceUserID string, targetUserID string) {
	req := httptest.NewRequest(
		"POST",
		"/api/users/{id}/following",
		strings.NewReader(fmt.Sprintf(`{ "target_user_id": "%s" }`, targetUserID)),
	)
	req.SetPathValue("id", sourceUserID)

	rr := httptest.NewRecorder()
	CreateFollowship(rr, req, s.followUserUsecase)
}

// TestHandlersTestSuite runs all of the tests attached to HandlersTestSuite.
func TestHandlersTestSuite(t *testing.T) {
	suite.Run(t, new(HandlersTestSuite))
}
