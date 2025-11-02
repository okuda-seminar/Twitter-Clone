package handler

import (
	"encoding/json"
	"errors"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/controller/transfer"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

type CreateQuoteRepostHandler struct {
	createQuoteRepostUsecase  usecase.CreateQuoteRepostUsecase
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewCreateQuoteRepostHandler(createQuoteRepostUsecase usecase.CreateQuoteRepostUsecase, updateNotificationUsecase usecase.UpdateNotificationUsecase) CreateQuoteRepostHandler {
	return CreateQuoteRepostHandler{
		createQuoteRepostUsecase:  createQuoteRepostUsecase,
		updateNotificationUsecase: updateNotificationUsecase,
	}
}

// CreateQuoteRepost creates a new quote repost with the specified post_id and user_id,
// then, inserts it into reposts table.
func (h *CreateQuoteRepostHandler) CreateQuoteRepost(w http.ResponseWriter, r *http.Request, userID string) {
	var body openapi.CreateQuoteRepostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, ErrDecodeRequestBody.Error(), http.StatusBadRequest)
		return
	}

	quoteRepost, err := h.createQuoteRepostUsecase.CreateQuoteRepost(userID, body.PostId, body.Text)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrUserNotFound):
			http.Error(w, ErrUserNotFound.Error(), http.StatusBadRequest)
		case errors.Is(err, usecase.ErrTooLongText):
			http.Error(w, ErrTooLongText.Error(), http.StatusBadRequest)
		case errors.Is(err, usecase.ErrTimelineItemNotFound):
			http.Error(w, ErrTimelineItemNotFound.Error(), http.StatusBadRequest)
		case errors.Is(err, usecase.ErrRepostViolation):
			http.Error(w, ErrRepostViolation.Error(), http.StatusBadRequest)
		default:
			http.Error(w, ErrCreateQuoteRepost.Error(), http.StatusInternalServerError)
		}
		return
	}

	go h.updateNotificationUsecase.SendNotification(userID, entity.QuoteRepostCreated, &quoteRepost)

	res := transfer.ToCreateQuoteRepostResponse(&quoteRepost)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(res)
	if err != nil {
		http.Error(w, ErrEncodeResponse.Error(), http.StatusInternalServerError)
		return
	}
}
