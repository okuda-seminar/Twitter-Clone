package handler

// func (s *handlerTestSuite) TestDeletePost() {
// 	userID := s.newTestUser(`{ "username": "test user", "display_name": "test user", "password": "securepassword" }`)
// 	postID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test post" }`, userID))

// 	tests := []struct {
// 		name         string
// 		postID       string
// 		expectedCode int
// 	}{
// 		{
// 			name:         "delete a post successfully with a proper post ID.",
// 			postID:       postID,
// 			expectedCode: http.StatusNoContent,
// 		},
// 		{
// 			name:         "fail to delete a post that was already deleted .",
// 			postID:       postID,
// 			expectedCode: http.StatusNotFound,
// 		},
// 		{
// 			name:         "fail to delete a post with a non-existent post ID.",
// 			postID:       uuid.New().String(),
// 			expectedCode: http.StatusNotFound,
// 		},
// 	}

// 	for _, test := range tests {
// 		req := httptest.NewRequest("DELETE", "/api/posts{postID}",
// 			nil)
// 		req.SetPathValue("postID", test.postID)

// 		rr := httptest.NewRecorder()
// 		DeletePost(rr, req, s.db, &s.mu, &s.userChannels)

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
