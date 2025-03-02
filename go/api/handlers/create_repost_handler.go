package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"
	"x-clone-backend/internal/domain/entities"

	"github.com/google/uuid"
)

type CreateRepostHandler struct {
	db        *sql.DB
	mu        *sync.Mutex
	usersChan *map[string]chan entities.TimelineEvent
}

func NewCreateRepostHandler(db *sql.DB, mu *sync.Mutex, usersChan *map[string]chan entities.TimelineEvent) CreateRepostHandler {
	return CreateRepostHandler{
		db:        db,
		mu:        mu,
		usersChan: usersChan,
	}
}

// CreateRepost creates a new repost with the specified post_id and user_id,
// then, inserts it into reposts table.
func (h *CreateRepostHandler) CreateRepost(w http.ResponseWriter, r *http.Request) {
	var body createRepostRequestBody

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	query := `INSERT INTO reposts (post_id, user_id) VALUES ($1, $2)`

	_, err = h.db.Exec(query, body.PostID, body.UserID)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a repost."), http.StatusInternalServerError)
		return
	}

	var (
		userID    uuid.UUID
		text      string
		createdAt time.Time
	)

	query = `SELECT user_id, text, created_at FROM posts WHERE id = $1`
	err = h.db.QueryRow(query, body.PostID).Scan(&userID, &text, &createdAt)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not fetch the original post for repost."), http.StatusInternalServerError)
		return
	}

	post := entities.Post{
		ID:        body.PostID,
		UserID:    userID,
		Text:      text,
		CreatedAt: createdAt,
	}

	go func(userID uuid.UUID, userChan *map[string]chan entities.TimelineEvent) {
		var posts []*entities.Post
		posts = append(posts, &post)
		query = `SELECT source_user_id FROM followships WHERE target_user_id = $1`
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
			if userChan, ok := (*h.usersChan)[id.String()]; ok {
				userChan <- entities.TimelineEvent{EventType: entities.RepostCreated, Posts: posts}
			}
			h.mu.Unlock()
		}

	}(body.UserID, h.usersChan)

	w.WriteHeader(http.StatusCreated)
}
