package handler

// func (s *handlerTestSuite) TestUnlikePost() {
// 	// UnlikePost must use existing user ID and post ID
// 	// from the users and posts table.
// 	// Therefore, users and posts are created
// 	// for testing purposes to obtain these IDs.
// 	userID := s.newTestUser(`{ "username": "user", "display_name": "user", "password": "securepassword" }`)
// 	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test post" }`, userID))
// 	s.newTestLike(userID, postID)

// 	tests := []struct {
// 		name         string
// 		userID       string
// 		postID       string
// 		expectedCode int
// 	}{
// 		{
// 			name:         "unlike a post successfully with a proper pair of User and Post.",
// 			userID:       userID,
// 			postID:       postID,
// 			expectedCode: http.StatusNoContent,
// 		},
// 		{
// 			name:         "fail to unlike a post with a pair of non-existent User and proper Post.",
// 			userID:       uuid.New().String(),
// 			postID:       postID,
// 			expectedCode: http.StatusNotFound,
// 		},
// 		{
// 			name:         "fail to unlike a post with a pair of proper User and non-existent Post.",
// 			userID:       userID,
// 			postID:       uuid.New().String(),
// 			expectedCode: http.StatusNotFound,
// 		},
// 	}

// 	for _, test := range tests {
// 		req := httptest.NewRequest(
// 			"DELETE",
// 			"/api/users/{id}/likes/{post_id}",
// 			strings.NewReader(""),
// 		)
// 		req.SetPathValue("id", test.userID)
// 		req.SetPathValue("post_id", test.postID)

// 		rr := httptest.NewRecorder()
// 		UnlikePost(rr, req, s.unlikePostUsecase)

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
