package handler

import (
	"encoding/json"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

type CreateRepostHandler struct {
	createRepostUsecase       usecase.CreateRepostUsecase
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewCreateRepostHandler(createRepostUsecase usecase.CreateRepostUsecase, updateNotificationUsecase usecase.UpdateNotificationUsecase) CreateRepostHandler {
	return CreateRepostHandler{
		createRepostUsecase,
		updateNotificationUsecase,
	}
}

// CreateRepost creates a new repost with the specified postID and userID.
func (h *CreateRepostHandler) CreateRepost(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.CreateRepostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, ErrDecodeRequestBody.Error(), http.StatusBadRequest)
		return
	}

	repost, err := h.createRepostUsecase.CreateRepost(userID, body.PostId)
	if err != nil {
		http.Error(w, ErrCreateRepost.Error(), http.StatusInternalServerError)
		return
	}

	go h.updateNotificationUsecase.SendNotification(userID, entity.RepostCreated, &repost)

	res := transfer.ToCreateRepostResponse(&repost)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
