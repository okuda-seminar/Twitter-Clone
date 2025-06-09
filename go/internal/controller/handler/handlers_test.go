package handler

// func (s *handlerTestSuite) TestCreateMuting() {
// 	// CreateMuting must use existing user IDs from the user table
// 	// for both the source user ID and target user ID.
// 	// Therefore, users are created for testing purposes to obtain these IDs.
// 	sourceUserID := s.newTestUser(`{ "username": "test", "display_name": "test", "password": "securepassword" }`)
// 	targetUserID := s.newTestUser(`{ "username": "test2", "display_name": "test2", "password": "securepassword" }`)

// 	tests := []struct {
// 		name         string
// 		body         string
// 		expectedCode int
// 	}{
// 		{
// 			name:         "create muting",
// 			body:         `{ "target_user_id": "` + targetUserID + `" }`,
// 			expectedCode: http.StatusCreated,
// 		},
// 		{
// 			name:         "invalid JSON body",
// 			body:         `{ "target_user_id": "` + targetUserID,
// 			expectedCode: http.StatusBadRequest,
// 		},
// 		{
// 			name:         "invalid body",
// 			body:         `{ "invalid": "test" }`,
// 			expectedCode: http.StatusInternalServerError,
// 		},
// 		{
// 			name:         "duplicated muting",
// 			body:         `{ "target_user_id": "` + targetUserID + `" }`,
// 			expectedCode: http.StatusInternalServerError,
// 		},
// 	}

// 	for _, test := range tests {
// 		req := httptest.NewRequest(
// 			"POST",
// 			"/api/users/{id}/muting",
// 			strings.NewReader(test.body),
// 		)
// 		req.SetPathValue("id", sourceUserID)

// 		rr := httptest.NewRecorder()
// 		CreateMuting(rr, req, s.muteUserUsecase)

// 		if rr.Code != test.expectedCode {
// 			s.T().Errorf(
// 				"%s: wrong code returned; expected %d, but got %d",
// 				test.name,
// 				test.expectedCode,
// 				rr.Code,
// 			)
// 		}
// 	}
// }

// func (s *handlerTestSuite) newTestRepost(userID, postID string) string {
// 	req := httptest.NewRequest(
// 		"POST",
// 		fmt.Sprintf("/api/users/%s/reposts", userID),
// 		strings.NewReader(fmt.Sprintf(`{ "post_id": "%s" }`, postID)),
// 	)
// 	rr := httptest.NewRecorder()

// 	createRepostHandler := NewCreateRepostHandler(s.db, &s.mu, &s.userChannels)
// 	createRepostHandler.CreateRepost(rr, req, userID)

// 		var repost entity.TimelineItem
// 		_ = json.NewDecoder(rr.Body).Decode(&repost)
// 		repostID := repost.ID.String()
// 		return repostID
// }

// func (s *handlerTestSuite) newTestDeleteRepost(userID string, postID string, repostID string) {
// 	req := httptest.NewRequest(
// 		"DELETE",
// 		fmt.Sprintf("/api/users/%s/reposts/%s", userID, postID),
// 		strings.NewReader(fmt.Sprintf(`{ "repost_id": "%s" }`, repostID)),
// 	)

// 	rr := httptest.NewRecorder()

// 	deleteRepostHandler := NewDeleteRepostHandler(s.db, &s.mu, &s.userChannels)
// 	deleteRepostHandler.DeleteRepost(rr, req, userID, postID)
// }

// func (s *handlerTestSuite) newTestQuoteRepost(userID, postID string) string {
// 	req := httptest.NewRequest(
// 		"POST",
// 		fmt.Sprintf("/api/users/%s/quote_reposts", userID),
// 		strings.NewReader(fmt.Sprintf(`{ "post_id": "%s", "text": "test" }`, postID)),
// 	)
// 	rr := httptest.NewRecorder()

// 	createRepostHandler := NewCreateQuoteRepostHandler(s.db, &s.mu, &s.userChannels)
// 	createRepostHandler.CreateQuoteRepost(rr, req, userID)

// 		var repost entity.TimelineItem
// 		_ = json.NewDecoder(rr.Body).Decode(&repost)
// 		repostID := repost.ID.String()
// 		return repostID
// }

// func (s *handlerTestSuite) newTestUser(body string) string {
// 	req := httptest.NewRequest(
// 		"POST",
// 		"/api/users",
// 		strings.NewReader(body),
// 	)
// 	rr := httptest.NewRecorder()

// 	createUserHandler := NewCreateUserHandler(s.db, s.authService)
// 	createUserHandler.CreateUser(rr, req)

// 	var res map[string]interface{}

// 	err := json.NewDecoder(rr.Body).Decode(&res)
// 	if err != nil {
// 		s.T().Fatalf("Failed to decode response: %v", err)
// 	}

// 	sourceUserData, ok := res["user"].(map[string]interface{})
// 	if !ok {
// 		s.T().Fatalf("Invalid response format: 'user' key not found or invalid")
// 	}

// 	sourceUserID, ok := sourceUserData["id"].(string)
// 	if !ok {
// 		s.T().Fatalf("Invalid response format: 'id' key not found or invalid")
// 	}

// 	return sourceUserID
// }

// func (s *handlerTestSuite) newTestDeletePost(postID string) {
// 	req := httptest.NewRequest("DELETE", "/api/posts{postID}", nil)
// 	req.SetPathValue("postID", postID)

// 	rr := httptest.NewRecorder()
// 	DeletePost(rr, req, s.db, &s.mu, &s.userChannels)
// }

// func (s *handlerTestSuite) newTestPost(body string) string {
// 	req := httptest.NewRequest(
// 		"POST",
// 		"/api/posts",
// 		strings.NewReader(body),
// 	)
// 	rr := httptest.NewRecorder()

// 	createPostHandler := NewCreatePostHandler(s.db, &s.mu, &s.userChannels)
// 	createPostHandler.CreatePost(rr, req)

// 		var post entity.TimelineItem
// 		_ = json.NewDecoder(rr.Body).Decode(&post)
// 		postID := post.ID.String()
// 		return postID
// }

// func (s *handlerTestSuite) newTestLike(userID string, postID string) {
// 	req := httptest.NewRequest(
// 		"POST",
// 		"/api/users/{id}/likes",
// 		strings.NewReader(fmt.Sprintf(`{ "post_id": "%s" }`, postID)),
// 	)
// 	req.SetPathValue("id", userID)

// 	rr := httptest.NewRecorder()
// 	LikePost(rr, req, s.likePostUsecase)
// }

// func (s *handlerTestSuite) newTestFollow(sourceUserID string, targetUserID string) {
// 	req := httptest.NewRequest(
// 		"POST",
// 		"/api/users/{id}/following",
// 		strings.NewReader(fmt.Sprintf(`{ "target_user_id": "%s" }`, targetUserID)),
// 	)
// 	req.SetPathValue("id", sourceUserID)

// 	rr := httptest.NewRecorder()
// 	CreateFollowship(rr, req, s.followUserUsecase)
// }

// // TestHandlerTestSuite runs all of the tests attached to handlerTestSuite.
// func TestHandlerTestSuite(t *testing.T) {
// 	suite.Run(t, new(handlerTestSuite))
// }
