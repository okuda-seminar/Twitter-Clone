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
