package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	"x-clone-backend/api/transfers"
	"x-clone-backend/internal/app/services"
	"x-clone-backend/internal/app/usecases"
	infrastructure "x-clone-backend/internal/infrastructure/persistence"
	openapi "x-clone-backend/openapi"
)

type CreateUserHandler struct {
	createUserUsecase usecases.CreateUserUsecase
	authService       *services.AuthService
}

func NewCreateUserHandler(db *sql.DB, authService *services.AuthService) CreateUserHandler {
	usersRepository := infrastructure.NewUsersRepository(db)
	createUserUsecase := usecases.NewCreateUserUsecase(usersRepository)
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

		if isUniqueViolationError(err) {
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

	res := transfers.ToCreateUserResponse(&user, token)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
