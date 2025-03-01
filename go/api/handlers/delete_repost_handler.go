package handlers

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"sync"
	"x-clone-backend/internal/domain/entities"

	"github.com/google/uuid"
)

type DeleteRepostHandler struct {
	db        *sql.DB
	mu        *sync.Mutex
	usersChan *map[string]chan entities.TimelineEvent
}

func NewDeleteRepostHandler(db *sql.DB, mu *sync.Mutex, usersChan *map[string]chan entities.TimelineEvent) DeleteRepostHandler {
	return DeleteRepostHandler{
		db:        db,
		mu:        mu,
		usersChan: usersChan,
	}
}

// DeleteRepost deletes a repost with the specified post ID.
// If the post doesn't exist, it returns 404 error.
func (h *DeleteRepostHandler) DeleteRepost(w http.ResponseWriter, r *http.Request, userID string, postID string) {
	query := `DELETE FROM reposts WHERE post_id = $1 AND user_id = $2`

	res, err := h.db.Exec(query, postID, userID)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not delete a repost: (user id: %s, post id: %s)\n", userID, postID), http.StatusInternalServerError)
		return
	}

	cnt, err := res.RowsAffected()
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not delete a repost: (user id: %s, post id: %s)\n", userID, postID), http.StatusInternalServerError)
		return
	}
	if cnt != 1 {
		http.Error(w, fmt.Sprintf("No row found to delete: (user id: %s, post id: %s)\n", userID, postID), http.StatusNotFound)
		return
	}

	var post entities.Post

	query = `SELECT user_id, text, created_at FROM posts WHERE id=$1`
	err = h.db.QueryRow(query, postID).Scan(&post.UserID, &post.Text, &post.CreatedAt)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not fetch the original post for repost."), http.StatusInternalServerError)
		return
	}

	post.ID, err = uuid.Parse(postID)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not parse a postID (ID: %s)\n", postID), http.StatusBadRequest)
		return
	}

	go func(userID uuid.UUID, usersChan *map[string]chan entities.TimelineEvent) {
		var posts []*entities.Post
		posts = append(posts, &post)
		query = `SELECT source_user_id FROM followships WHERE target_user_id=$1`
		rows, err := h.db.Query(query, userID.String())
		if err != nil {
			log.Fatalln(err)
			return
		}

		var ids []uuid.UUID
		for rows.Next() {
			var id uuid.UUID
			if err := rows.Scan(&id); err != nil {
				log.Fatalln(err)
				return
			}

			ids = append(ids, id)
		}
		ids = append(ids, userID)
		for _, id := range ids {
			h.mu.Lock()
			if userChan, ok := (*usersChan)[id.String()]; ok {
				userChan <- entities.TimelineEvent{EventType: entities.RepostDeleted, Posts: posts}
			}
			h.mu.Unlock()
		}
	}(post.UserID, h.usersChan)

	w.WriteHeader(http.StatusNoContent)
}
