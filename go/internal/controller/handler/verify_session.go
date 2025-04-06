package handler

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/controller/transfer"
	"x-clone-backend/internal/infrastructure/persistence"
)

type VerifySessionHandler struct {
	authService            *service.AuthService
	getSpecificUserUsecase usecase.GetSpecificUserUsecase
}

func NewVerifySessionHandler(db *sql.DB, authService *service.AuthService) VerifySessionHandler {
	usersRepository := persistence.NewUsersRepository(db)
	getSpecificUserUsecase := interactor.NewGetSpecificUserUsecase(usersRepository)
	return VerifySessionHandler{
		authService:            authService,
		getSpecificUserUsecase: getSpecificUserUsecase,
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

	user, err := h.getSpecificUserUsecase.GetSpecificUser(userID)
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
