package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
)

func (s *handlerTestSuite) TestDeleteUser() {
	userID := s.newTestUser(`{ "username": "delete_test", "display_name": "Delete User", "password": "securepassword" }`)

	tests := []struct {
		name         string
		userID       string
		body         string
		expectedCode int
	}{
		{
			name:         "delete existing user",
			userID:       userID,
			body:         fmt.Sprintf(`{ "user_id": "%s" }`, userID),
			expectedCode: http.StatusNoContent,
		},
		{
			name:         "delete non-existent user",
			userID:       userID,
			body:         fmt.Sprintf(`{ "user_id": "%s" }`, userID),
			expectedCode: http.StatusNotFound,
		},
	}

	for _, test := range tests {
		rr := httptest.NewRecorder()
		req := httptest.NewRequest(
			"DELETE",
			fmt.Sprintf("/api/users/%s", test.userID),
			strings.NewReader(test.body),
		)
		req.SetPathValue("userID", test.userID)

		deleteUserHandler := NewDeleteUserHandler(s.deleteUserUsecase)
		deleteUserHandler.DeleteUser(rr, req, test.userID)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}
	}
}
