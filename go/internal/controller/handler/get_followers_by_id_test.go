package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/entity"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
)

func TestGetFollowersByID(t *testing.T) {
	sourceUserID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		setup        func(getFollowersByIDUsecase usecase.GetFollowersByIDUsecase)
		expectedCode int
	}{
		"returns 200 with followers when user has followers": {
			userID: sourceUserID,
			setup: func(getFollowersByIDUsecase usecase.GetFollowersByIDUsecase) {
				getFollowersByIDUsecase.SetFollowers([]entity.User{
					{
						ID:       uuid.NewString(),
						Username: "follower1",
					},
				})
			},
			expectedCode: http.StatusOK,
		},
		"returns 200 with empty array when user has no followers": {
			userID:       sourceUserID,
			expectedCode: http.StatusOK,
		},
		"returns 404 when user does not exist": {
			userID: uuid.NewString(),
			setup: func(getFollowersByIDUsecase usecase.GetFollowersByIDUsecase) {
				getFollowersByIDUsecase.SetError(usecase.ErrUserNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
		"returns 500 when unexpected error occurs": {
			userID: sourceUserID,
			setup: func(getFollowersByIDUsecase usecase.GetFollowersByIDUsecase) {
				getFollowersByIDUsecase.SetError(fmt.Errorf("unexpected database error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			usersRepository := infraInjector.InjectUsersRepository(nil)
			getFollowersByIDUsecase := usecaseInjector.InjectGetFollowersByIDUsecase(usersRepository)
			getFollowersByIDHandler := NewGetFollowersByIDHandler(getFollowersByIDUsecase)

			if tt.setup != nil {
				tt.setup(getFollowersByIDUsecase)
			}

			req := httptest.NewRequest(
				http.MethodGet,
				fmt.Sprintf("/api/users/%s/followers", tt.userID),
				nil,
			)
			rr := httptest.NewRecorder()

			getFollowersByIDHandler.GetFollowersByID(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
