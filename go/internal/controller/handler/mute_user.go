package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/openapi"
)

type MuteUserHandler struct {
	muteUserUsecase usecase.MuteUserUsecase
}

func NewMuteUserHandler(muteUserUsecase usecase.MuteUserUsecase) MuteUserHandler {
	return MuteUserHandler{
		muteUserUsecase,
	}
}

func (h *MuteUserHandler) MuteUser(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.MuteUserRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, ErrDecodeRequestBody.Error(), http.StatusBadRequest)
		return
	}

	err = h.muteUserUsecase.MuteUser(userID, body.TargetUserId)
	if err != nil {
		http.Error(w, ErrCreateMuting.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}
