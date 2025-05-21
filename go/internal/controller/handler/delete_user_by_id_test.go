package handler

import (
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
)

func TestDeleteUserByID(t *testing.T) {
	tests := map[string]struct {
		setup        func(deleteUserByIDUsecase usecase.DeleteUserByIDUsecase)
		expectedCode int
	}{
		"returns 204 when user is deleted successfully": {
			setup:        nil,
			expectedCode: http.StatusNoContent,
		},
		"returns 404 when user is not found": {
			setup: func(deleteUserByIDUsecase usecase.DeleteUserByIDUsecase) {
				deleteUserByIDUsecase.SetError(usecase.ErrUserNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
		"returns 500 when there is a server error": {
			setup: func(deleteUserByIDUsecase usecase.DeleteUserByIDUsecase) {
				deleteUserByIDUsecase.SetError(errors.New("Could not delete a user"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			t.Parallel()

			userID := uuid.New().String()

			deleteUserByIDUsecase := usecaseInjector.InjectDeleteUserByIDUsecase(nil)
			deleteUserByIDHandler := NewDeleteUserByIDHandler(deleteUserByIDUsecase)

			if tt.setup != nil {
				tt.setup(deleteUserByIDUsecase)
			}

			req := httptest.NewRequest(
				http.MethodDelete,
				fmt.Sprintf("/api/users/%s", userID),
				nil,
			)
			rr := httptest.NewRecorder()

			deleteUserByIDHandler.DeleteUserByID(rr, req, userID)

			if rr.Code != tt.expectedCode {
				t.Errorf("[%s] expected status %d; got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
