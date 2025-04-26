package handler

import (
	"encoding/json"
	"net/http"

	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/openapi"
)

// CreateFollowshipHandler handles the POST /api/users/{id}/following
type CreateFollowshipHandler struct {
	usecase usecase.FollowUserUsecase
}

// NewCreateFollowshipHandler initializes the handler with its dependencies
func NewCreateFollowshipHandler(repo repository.UsersRepository) CreateFollowshipHandler {
	createFollowshipUsecase := interactor.NewFollowUserUsecase(repo)
	return CreateFollowshipHandler{
		usecase: createFollowshipUsecase,
	}
}

// createFollowshipRequestBody is the type of the "CreateFollowship"
// endpoint request body.
// Successful: returns status code 201
func (h *CreateFollowshipHandler) CreateFollowship(w http.ResponseWriter, r *http.Request, id string) {
	var body openapi.CreateFollowshipRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, ErrInvalidRequestBody.Error(), http.StatusBadRequest)
		return
	}

	sourceUserID := id

	err = h.usecase.FollowUser(sourceUserID, body.TargetUserID)
	if err != nil {
		http.Error(w, ErrCreateFollowship.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}
