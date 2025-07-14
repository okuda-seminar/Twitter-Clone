package handler

import (
	"encoding/json"
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
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/786
	// - Update OpenAPI Schema to Support More Conditions for BlockUser.
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, ErrDecodeRequestBody.Error(), http.StatusBadRequest)
		return
	}

	err = h.blockUserUsecase.BlockUser(userID, body.TargetUserId)
	if err != nil {
		http.Error(w, ErrCreateBlock.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}
