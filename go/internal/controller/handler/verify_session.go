package handler

import (
	"encoding/json"
	"net/http"

	"x-clone-backend/internal/application/service"
	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
)

type VerifySessionHandler struct {
	authService         *service.AuthService
	userByUserIDUsecase usecase.UserByUserIDUsecase
}

func NewVerifySessionHandler(authService *service.AuthService, userByUserIDUsecase usecase.UserByUserIDUsecase) VerifySessionHandler {
	return VerifySessionHandler{
		authService,
		userByUserIDUsecase,
	}
}

func (h *VerifySessionHandler) VerifySession(w http.ResponseWriter, r *http.Request) {
	token, err := service.ExtractTokenFromHeader(r)
	if err != nil {
		http.Error(w, "Invalid or expired token.", http.StatusUnauthorized)
		return
	}

	userID, err := h.authService.ValidateJWT(token)
	if err != nil {
		http.Error(w, "Invalid or expired token.", http.StatusUnauthorized)
		return
	}

	user, err := h.userByUserIDUsecase.UserByUserID(userID)
	if err != nil {
		http.Error(w, "Unexpected error occurred.", http.StatusInternalServerError)
		return
	}

	res := transfer.ToVerifySessionResponse(&user)

	w.Header().Set("Content-Type", "application/json")
	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, "Unexpected error occurred.", http.StatusInternalServerError)
		return
	}
}
