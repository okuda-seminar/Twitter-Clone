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

func TestGetFolloweesByID(t *testing.T) {
	sourceUserID := uuid.NewString()

	tests := map[string]struct {
		userID       string
		setup        func(getFolloweesByIDUsecase usecase.GetFolloweesByIDUsecase)
		expectedCode int
	}{
		"returns 200 with followees when user has followees": {
			userID: sourceUserID,
			setup: func(getFolloweesByIDUsecase usecase.GetFolloweesByIDUsecase) {
				getFolloweesByIDUsecase.SetFollowees([]entity.User{
					{
						ID:       uuid.NewString(),
						Username: "followee1",
					},
				})
			},
			expectedCode: http.StatusOK,
		},
		"returns 200 with empty array when user has no followees": {
			userID:       sourceUserID,
			expectedCode: http.StatusOK,
		},
		"returns 404 when user does not exist": {
			userID: uuid.NewString(),
			setup: func(getFolloweesByIDUsecase usecase.GetFolloweesByIDUsecase) {
				getFolloweesByIDUsecase.SetError(usecase.ErrUserNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
		"returns 500 when unexpected error occurs": {
			userID: sourceUserID,
			setup: func(getFolloweesByIDUsecase usecase.GetFolloweesByIDUsecase) {
				getFolloweesByIDUsecase.SetError(fmt.Errorf("unexpected database error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			usersRepository := infraInjector.InjectUsersRepository(nil)
			getFolloweesByIDUsecase := usecaseInjector.InjectGetFolloweesByIDUsecase(usersRepository)
			getFolloweesByIDHandler := NewGetFolloweesByIDHandler(getFolloweesByIDUsecase)

			if tt.setup != nil {
				tt.setup(getFolloweesByIDUsecase)
			}

			req := httptest.NewRequest(
				http.MethodGet,
				fmt.Sprintf("/api/users/%s/followees", tt.userID),
				nil,
			)
			rr := httptest.NewRecorder()

			getFolloweesByIDHandler.GetFolloweesByID(rr, req, tt.userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
