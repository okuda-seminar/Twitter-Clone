package handler

import (
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/domain/repository"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
)

func TestDeleteFollowship(t *testing.T) {
	sourceUserID := uuid.NewString()
	targetUserID := uuid.NewString()

	tests := map[string]struct {
		setupRepo    func(repo repository.UsersRepository)
		expectedCode int
	}{
		"DeleteFollowship successfully": {
			setupRepo: func(repo repository.UsersRepository) {
				repo.FollowUser(nil, sourceUserID, targetUserID)
			},
			expectedCode: http.StatusNoContent,
		},
		"FollowshipNotFound": {
			setupRepo:    nil,
			expectedCode: http.StatusNotFound,
		},
		"UseCaseError": {
			setupRepo: func(repo repository.UsersRepository) {
				repo.SetError("UnfollowUser", errors.New("usecase failure"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			t.Parallel()

			usersRepository := infraInjector.InjectUsersRepository(nil)
			if tt.setupRepo != nil {
				tt.setupRepo(usersRepository)
			}

			unfollowUserUsecase := usecaseInjector.InjectUnfollowUserUsecase(usersRepository)
			h := NewDeleteFollowshipHandler(unfollowUserUsecase)

			req := httptest.NewRequest(
				http.MethodDelete,
				fmt.Sprintf("/api/users/%s/following/%s", sourceUserID, targetUserID),
				nil,
			)
			rr := httptest.NewRecorder()
			h.DeleteFollowship(rr, req, sourceUserID, targetUserID)

			if rr.Code != tt.expectedCode {
				t.Errorf("[%s] expected status %d; got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
