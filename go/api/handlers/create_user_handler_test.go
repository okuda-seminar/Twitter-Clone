package handlers

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"strings"
)

func (s *HandlersTestSuite) TestCreateUser() {
	tests := []struct {
		name         string
		body         string
		expectedCode int
	}{
		{
			name:         "create user",
			body:         `{ "username": "test", "display_name": "test", "password": "securepassword" }`,
			expectedCode: http.StatusCreated,
		},
		{
			name:         "invalid JSON body",
			body:         `{ "username": "` + "test",
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "invalid body",
			body:         `{ "invalid": "test", "password": "securepassword" }`,
			expectedCode: http.StatusInternalServerError,
		},
		{
			name:         "duplicated username",
			body:         `{ "username": "test", "display_name": "duplicated", "password": "securepassword" }`,
			expectedCode: http.StatusConflict,
		},
		{
			name:         "password too short",
			body:         `{ "username": "test2", "display_name": "duplicated", "password": "shortpw" }`,
			expectedCode: http.StatusBadRequest,
		},
		{
			name:         "password too long",
			body:         `{ "username": "test3", "display_name": "duplicated", "password": "longsecurepassword" }`,
			expectedCode: http.StatusBadRequest,
		},
	}

	for _, test := range tests {
		createUserHandler := NewCreateUserHandler(s.db, s.authService)

		req := httptest.NewRequest("POST", "/api/users", strings.NewReader(test.body))
		rr := httptest.NewRecorder()

		createUserHandler.CreateUser(rr, req)

		if rr.Code != test.expectedCode {
			s.T().Errorf("%s: wrong code returned; expected %d, but got %d", test.name, test.expectedCode, rr.Code)
		}

		if test.expectedCode == http.StatusCreated {
			var res map[string]interface{}
			err := json.Unmarshal(rr.Body.Bytes(), &res)
			if err != nil {
				s.T().Errorf("%s: failed to parse response body: %v", test.name, err)
				continue
			}

			if _, ok := res["token"]; !ok {
				s.T().Errorf("%s: token not found in response", test.name)
			}

			if _, ok := res["user"]; !ok {
				s.T().Errorf("%s: user not found in response", test.name)
			}
		}
	}
}
