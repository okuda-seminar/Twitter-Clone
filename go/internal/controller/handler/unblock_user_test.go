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

func TestUnblockUser(t *testing.T) {
	existingSourceUserID := uuid.NewString()
	existingTargetUserID := uuid.NewString()

	tests := map[string]struct {
		sourceUserID string
		targetUserID string
		setup        func(unblockUserUsecase usecase.UnblockUserUsecase)
		expectedCode int
	}{
		"successfully unblock user": {
			sourceUserID: existingSourceUserID,
			targetUserID: existingTargetUserID,
			expectedCode: http.StatusNoContent,
		},
		"block not found": {
			sourceUserID: existingSourceUserID,
			targetUserID: existingTargetUserID,
			setup: func(unblockUserUsecase usecase.UnblockUserUsecase) {
				unblockUserUsecase.SetError(usecase.ErrBlockNotFound)
			},
			expectedCode: http.StatusNotFound,
		},
		"unexpected error occurred": {
			sourceUserID: existingSourceUserID,
			targetUserID: existingTargetUserID,
			setup: func(unblockUserUsecase usecase.UnblockUserUsecase) {
				unblockUserUsecase.SetError(fmt.Errorf("unexpected error"))
			},
			expectedCode: http.StatusInternalServerError,
		},
	}

	for name, tt := range tests {
		t.Run(name, func(t *testing.T) {
			unblockUserUsecase := injector.InjectUnblockUserUsecase(nil)
			UnblockUserHandler := NewUnblockUserHandler(unblockUserUsecase)

			if tt.setup != nil {
				tt.setup(unblockUserUsecase)
			}

			req := httptest.NewRequest(
				http.MethodDelete,
				fmt.Sprintf("/api/users/%s/blocking/%s", tt.sourceUserID, tt.targetUserID),
				nil,
			)
			rr := httptest.NewRecorder()

			UnblockUserHandler.UnblockUser(rr, req, tt.sourceUserID, tt.targetUserID)

			if rr.Code != tt.expectedCode {
				t.Errorf("%s: wrong code returned; expected %d, but got %d", name, tt.expectedCode, rr.Code)
			}
		})
	}
}
