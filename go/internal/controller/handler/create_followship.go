package handler

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/infrastructure/persistence"
)

// CreateFollowshipHandler handles the POST /api/users/{id}/following
type CreateFollowshipHandler struct {
	db      *sql.DB
	usecase usecase.FollowUserUsecase
}

// NewCreateFollowshipHandler initializes the handler with its dependencies
func NewCreateFollowshipHandler(db *sql.DB) CreateFollowshipHandler {
	usersRepository := persistence.NewUsersRepository(db)
	createFollowshipUsecase := interactor.NewFollowUserUsecase(usersRepository)
	return CreateFollowshipHandler{
		db:      db,
		usecase: createFollowshipUsecase,
	}
}

// createFollowshipRequestBody is the type of the "CreateFollowship"
// endpoint request body.
// Successful: returns status code 201
func (h *CreateFollowshipHandler) CreateFollowship(w http.ResponseWriter, r *http.Request, id string) {
	var body createFollowshipRequestBody

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, "Request body was invalid.", http.StatusBadRequest)
		return
	}

	sourceUserID := id

	err = h.usecase.FollowUser(sourceUserID, body.TargetUserID)
	if err != nil {
		http.Error(w, "Could not create followship.", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}
