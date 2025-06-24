package handler

import (
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

type DeletePostHandler struct {
	deletePostUsecase         usecase.DeletePostUsecase
	updateNotificationUsecase usecase.UpdateNotificationUsecase
}

func NewDeletePostHandler(deletePostUsecase usecase.DeletePostUsecase, updateNotificationUsecase usecase.UpdateNotificationUsecase) DeletePostHandler {
	return DeletePostHandler{
		deletePostUsecase,
		updateNotificationUsecase,
	}
}

// DeletePost deletes a post with the specified post ID.
// If the post doesn't exist, it returns 404 error.
func (h *DeletePostHandler) DeletePost(w http.ResponseWriter, r *http.Request, postID string) {
	post, err := h.deletePostUsecase.DeletePost(postID)
	if err != nil {
		http.Error(w, ErrDeletePostFailed.Error(), http.StatusInternalServerError)
		return
	}

	go h.updateNotificationUsecase.SendNotification(post.AuthorID, entity.PostDeleted, &post)

	w.WriteHeader(http.StatusNoContent)
}
