package handler

import (
	"encoding/json"
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
	"x-clone-backend/internal/openapi"
)

type LoginHandler struct {
	loginUsecase usecase.LoginUsecase
}

func NewLoginHandler(loginUsecase usecase.LoginUsecase) LoginHandler {
	return LoginHandler{
		loginUsecase,
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

	user, token, err := h.loginUsecase.Login(body.Username, body.Password)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrUserNotFound):
			http.Error(w, err.Error(), http.StatusNotFound)
		case errors.Is(err, usecase.ErrInvalidCredentials):
			http.Error(w, err.Error(), http.StatusUnauthorized)
		default:
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		}
		return
	}

	res := transfer.ToLoginResponse(&user, token)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, "Could not encode response.", http.StatusInternalServerError)
		return
	}
}
