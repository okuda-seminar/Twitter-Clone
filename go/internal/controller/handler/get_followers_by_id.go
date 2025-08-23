package handler

import (
	"net/http"
)

type GetFollowersByIDHandler struct {
}

func NewGetFollowersByIDHandler() GetFollowersByIDHandler {
	return GetFollowersByIDHandler{}
}

func (h GetFollowersByIDHandler) GetFollowersByID(w http.ResponseWriter, r *http.Request, userId string) {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/819 - Complete GetFollowersByID implementation.
	w.WriteHeader(http.StatusOK)
}
