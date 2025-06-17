package handler

import (
	"encoding/json"
	"fmt"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/openapi"
)

type BlockUserHandler struct {
	blockUserUsecase usecase.BlockUserUsecase
}

func NewBlockUserHandler(blockUserUsecase usecase.BlockUserUsecase) BlockUserHandler {
	return BlockUserHandler{
		blockUserUsecase,
	}
}

func (h *BlockUserHandler) BlockUser(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.BlockUserRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintf("Request body was invalid: %v", err), http.StatusBadRequest)
		return
	}

	err = h.blockUserUsecase.BlockUser(userID, body.TargetUserId)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not create block: %v", err), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}
