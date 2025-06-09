package handler

// func (s *handlerTestSuite) TestLikePost() {
// 	// LikePost must use existing user ID and post ID
// 	// from the users and posts table.
// 	// Therefore, users and posts are created
// 	// for testing purposes to obtain these IDs.
// 	authorUserID := s.newTestUser(`{ "username": "author", "display_name": "author", "password": "securepassword" }`)
// 	likerUserID := s.newTestUser(`{ "username": "liker", "display_name": "liker", "password": "securepassword" }`)
// 	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test post" }`, authorUserID))

// 	tests := []struct {
// 		name         string
// 		userID       string
// 		body         string
// 		expectedCode int
// 	}{
// 		{
// 			name:         "like an own post successfully with a proper pair of User and Post",
// 			userID:       authorUserID,
// 			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
// 			expectedCode: http.StatusCreated,
// 		},
// 		{
// 			name:         "like another user's post successfully with a proper pair of User and Post",
// 			userID:       likerUserID,
// 			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
// 			expectedCode: http.StatusCreated,
// 		},
// 		{
// 			name:         "fail to like another user's post with a invalid JSON body",
// 			userID:       likerUserID,
// 			body:         fmt.Sprintf(`{ "post_id": "%s"`, postID),
// 			expectedCode: http.StatusBadRequest,
// 		},
// 		{
// 			name:         "fail to like a post with a invalid JSON field",
// 			userID:       likerUserID,
// 			body:         `{ "invalid": "test" }`,
// 			expectedCode: http.StatusInternalServerError,
// 		},
// 		{
// 			name:         "fail to like a post with a pair of non-existent User and proper Post",
// 			userID:       uuid.New().String(),
// 			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
// 			expectedCode: http.StatusInternalServerError,
// 		},
// 		{
// 			name:         "fail to like a post with a pair of proper User and non-existent Post",
// 			userID:       likerUserID,
// 			body:         fmt.Sprintf(`{ "post_id": "%s" }`, uuid.New().String()),
// 			expectedCode: http.StatusInternalServerError,
// 		},
// 		{
// 			name:         "fail to like another user's post duplicately with a proper pair of User and Post",
// 			userID:       likerUserID,
// 			body:         fmt.Sprintf(`{ "post_id": "%s" }`, postID),
// 			expectedCode: http.StatusInternalServerError,
// 		},
// 	}

// 	for _, test := range tests {
// 		req := httptest.NewRequest(
// 			"POST",
// 			"/api/users/{id}/likes",
// 			strings.NewReader(test.body),
// 		)
// 		req.SetPathValue("id", test.userID)

// 		rr := httptest.NewRecorder()
// 		LikePost(rr, req, s.likePostUsecase)

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
