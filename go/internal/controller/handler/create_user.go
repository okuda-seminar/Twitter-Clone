package handler

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/controller/transfer"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/openapi"
)

type CreateUserHandler struct {
	createUserUsecase usecase.CreateUserUsecase
	authService       *service.AuthService
}

func NewCreateUserHandler(repo repository.UsersRepository, authService *service.AuthService) CreateUserHandler {
	createUserUsecase := interactor.NewCreateUserUsecase(repo)
	return CreateUserHandler{
		createUserUsecase,
		authService,
	}
}

// CreateUser creates a new user with the specified useranme and display name,
// then, inserts it into users table.
func (h *CreateUserHandler) CreateUser(w http.ResponseWriter, r *http.Request) {
	var body openapi.CreateUserRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	err = h.authService.ValidatePassword(body.Password)
	if err != nil {
		http.Error(w, fmt.Sprintf("Invalid Password: %v", err), http.StatusBadRequest)
		return
	}

	hashedPassword, err := h.authService.HashPassword(body.Password)
	if err != nil {
		http.Error(w, "Could not hash password.", http.StatusInternalServerError)
		return
	}

	user, err := h.createUserUsecase.CreateUser(body.Username, body.DisplayName, hashedPassword)
	if err != nil {
		var code int

		if errors.Is(err, usecase.ErrUserAlreadyExists) {
			code = http.StatusConflict
		} else {
			code = http.StatusInternalServerError
		}
		http.Error(w, fmt.Sprintln("Could not create a user."), code)
		return
	}

	token, err := h.authService.GenerateJWT(user.ID, user.Username)
	if err != nil {
		http.Error(w, "Could not generate token.", http.StatusInternalServerError)
		return
	}

	res := transfer.ToCreateUserResponse(&user, token)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
