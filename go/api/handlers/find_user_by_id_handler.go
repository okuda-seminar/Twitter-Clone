package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log/slog"
	"net/http"
	"x-clone-backend/api/transfers"
	"x-clone-backend/internal/app/usecases"
	infrastructure "x-clone-backend/internal/infrastructure/persistence"
)

type FindUserByIDHandler struct {
	getSpecificUserUsecase usecases.GetSpecificUserUsecase
}

func NewFindUserByIDHandler(db *sql.DB) FindUserByIDHandler {
	usersRepository := infrastructure.NewUsersRepository(db)
	getSpecificUserUsecase := usecases.NewGetSpecificUserUsecase(usersRepository)
	return FindUserByIDHandler{
		getSpecificUserUsecase,
	}
}

// FindUserByID finds a user with the specified ID.
func (h *FindUserByIDHandler) FindUserByID(w http.ResponseWriter, r *http.Request, userID string) {
	slog.Info("GET /api/users/{userID} was called.")

	user, err := h.getSpecificUserUsecase.GetSpecificUser(userID)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not find a user (ID: %s)\n", userID), http.StatusNotFound)
		return
	}
	res := transfers.ToFindUserByIDResponse(&user)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
