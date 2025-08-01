package handler

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/application/usecase/injector"
)

func TestUnmuteUser(t *testing.T) {
	existingSourceUserID := uuid.NewString()
	existingTargetUserID := uuid.NewString()

	tests := map[string]struct {
		sourceUserID string
		targetUserID string
		setup        func(unmuteUsecase usecase.UnmuteUserUsecase)
		expectedCode int
	}{
		"successfully unmute user": {
			sourceUserID: existingSourceUserID,
			targetUserID: existingTargetUserID,
			expectedCode: http.StatusNoContent,
		},
		"mute record not found": {
			sourceUserID: existingSourceUserID,
			targetUserID: existingTargetUserID,
			setup: func(unmuteUsecase usecase.UnmuteUserUsecase) {
				unmuteUsecase.SetError(usecase.ErrMuteNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
		"unexpected error occurred": {
			sourceUserID: existingSourceUserID,
			targetUserID: existingTargetUserID,
			setup: func(unmuteUsecase usecase.UnmuteUserUsecase) {
				unmuteUsecase.SetError(fmt.Errorf("unexpected error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			unmuteUsecase := injector.InjectUnmuteUserUsecase(nil)
			UnmuteUserHandler := NewUnmuteUserHandler(unmuteUsecase)

			if tt.setup != nil {
				tt.setup(unmuteUsecase)
			}

			req := httptest.NewRequest(
				http.MethodDelete,
				fmt.Sprintf("/api/users/%s/muting/%s", tt.sourceUserID, tt.targetUserID),
				nil,
			)
			rr := httptest.NewRecorder()

			UnmuteUserHandler.UnmuteUser(rr, req, tt.sourceUserID, tt.targetUserID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
