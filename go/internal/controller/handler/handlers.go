package handler

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"net/http"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
)

// DeleteUser deletes a user with the specified user ID.
// If a target user does not exist, it returns 404.
func DeleteUserByID(w http.ResponseWriter, r *http.Request, u usecase.DeleteUserUsecase) {
	userID := r.PathValue("userID")

	slog.Info(fmt.Sprintf("DELETE /api/users was called with %s.", userID))

	err := u.DeleteUser(userID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrUserNotFound):
			http.Error(w, fmt.Sprintf("No row found to delete (ID: %s)\n", userID), http.StatusNotFound)
		default:
			http.Error(w, fmt.Sprintf("Could not delete a user (ID: %s)\n", userID), http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

// DeletePost deletes a post with the specified post ID.
// If the post doesn't exist, it returns 404 error.
func DeletePost(w http.ResponseWriter, r *http.Request, db *sql.DB, updateNotificationUsecase usecase.UpdateNotificationUsecase) {
	postID := r.PathValue("postID")
	slog.Info(fmt.Sprintf("DELETE /api/posts was called with %s.", postID))

	query := `DELETE FROM timelineitems WHERE id = $1 RETURNING type, author_id, text, created_at`
	var post entity.TimelineItem

	err := db.QueryRow(query, postID).Scan(&post.Type, &post.AuthorID, &post.Text, &post.CreatedAt)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			http.Error(w, fmt.Sprintf("No row found to delete (ID: %s)\n", postID), http.StatusNotFound)
			return
		}

		http.Error(w, fmt.Sprintf("Could not delete a post (ID: %s)\n", postID), http.StatusInternalServerError)
		return
	}

	post.ID = postID

	go updateNotificationUsecase.SendNotification(post.AuthorID, entity.PostDeleted, &post)

	w.WriteHeader(http.StatusNoContent)
}

// LikePost creates a like with the specified user_id and post_id,
// then, inserts it into likes table.
func LikePost(w http.ResponseWriter, r *http.Request, u usecase.LikePostUsecase) {
	var body likePostRequestBody

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	userID := r.PathValue("id")

	slog.Info(fmt.Sprintf("POST /api/users/{id}/likes was called with %s.", userID))

	err = u.LikePost(userID, body.PostID)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a like."), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

func UnlikePost(w http.ResponseWriter, r *http.Request, u usecase.UnlikePostUsecase) {
	userID := r.PathValue("id")
	postID := r.PathValue("post_id")

	slog.Info(fmt.Sprintf("DELETE /api/users/{id}/likes/{post_id} was called with %s and %s.", userID, postID))

	err := u.UnlikePost(userID, postID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrLikeNotFound):
			http.Error(w, "No row found to delete", http.StatusNotFound)
		default:
			http.Error(w, fmt.Sprintf("Could not delete a like: %v", err), http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

func CreateMuting(w http.ResponseWriter, r *http.Request, u usecase.MuteUserUsecase) {
	var body createMutingRequestBody

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintf("Request body was invalid: %v", err), http.StatusBadRequest)
		return
	}

	sourceUserID := r.PathValue("id")

	err = u.MuteUser(sourceUserID, body.TargetUserID)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not create muting: %v", err), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

func DeleteMuting(w http.ResponseWriter, r *http.Request, u usecase.UnmuteUserUsecase) {
	sourceUserID := r.PathValue("source_user_id")
	targetUserID := r.PathValue("target_user_id")

	err := u.UnmuteUser(sourceUserID, targetUserID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrMuteNotFound):
			http.Error(w, "No row found to delete", http.StatusNotFound)
		default:
			http.Error(w, "Could not delete mute.", http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

func CreateBlocking(w http.ResponseWriter, r *http.Request, u usecase.BlockUserUsecase) {
	var body createBlockingRequestBody

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintf("Request body was invalid: %v", err), http.StatusBadRequest)
		return
	}

	sourceUserID := r.PathValue("id")
	targetUserID := body.TargetUserID

	err = u.BlockUser(sourceUserID, targetUserID)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not create block: %v", err), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

func DeleteBlocking(w http.ResponseWriter, r *http.Request, u usecase.UnblockUserUsecase) {
	sourceUserID := r.PathValue("source_user_id")
	targetUserID := r.PathValue("target_user_id")

	err := u.UnblockUser(sourceUserID, targetUserID)
	if err != nil {
		switch {
		case errors.Is(err, usecase.ErrBlockNotFound):
			http.Error(w, "No row found to delete", http.StatusNotFound)
		default:
			http.Error(w, "Could not delete blocking.", http.StatusInternalServerError)
		}
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
