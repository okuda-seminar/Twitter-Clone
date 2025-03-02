package handlers

import (
	"database/sql"
	"encoding/json"
	"errors"
	"net/http"

	"x-clone-backend/api/transfers"
	domainerrors "x-clone-backend/internal/app/errors"
	"x-clone-backend/internal/app/services"
	"x-clone-backend/internal/app/usecases"
	infrastructure "x-clone-backend/internal/infrastructure/persistence"
	openapi "x-clone-backend/openapi"
)

type LoginHandler struct {
	loginUseCase usecases.LoginUseCase
}

func NewLoginHandler(db *sql.DB, authService *services.AuthService) LoginHandler {
	usersRepository := infrastructure.NewUsersRepository(db)
	loginUseCase := usecases.NewLoginUseCase(usersRepository, authService)
	return LoginHandler{
		loginUseCase,
	}
}

func (h *LoginHandler) Login(w http.ResponseWriter, r *http.Request) {
	var body openapi.LoginRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, "Request body was invalid.", http.StatusBadRequest)
		return
	}

	if body.Username == "" || body.Password == "" {
		http.Error(w, "Username and password cannot be empty.", http.StatusBadRequest)
		return
	}

	user, token, err := h.loginUseCase.Login(body.Username, body.Password)
	if err != nil {
		switch {
		case errors.Is(err, domainerrors.ErrUserNotFound):
			http.Error(w, err.Error(), http.StatusNotFound)
		case errors.Is(err, domainerrors.ErrInvalidCredentials):
			http.Error(w, err.Error(), http.StatusUnauthorized)
		default:
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		}
		return
	}

	res := transfers.ToLoginResponse(&user, token)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, "Could not encode response.", http.StatusInternalServerError)
		return
	}
}
