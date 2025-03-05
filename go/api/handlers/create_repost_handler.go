package handlers

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"
	"x-clone-backend/internal/domain/entities"
	"x-clone-backend/openapi"

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
func (h *CreateRepostHandler) CreateRepost(w http.ResponseWriter, r *http.Request, userIDStr string) {
	var body openapi.CreateRepostRequest

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&body)
	if err != nil {
		http.Error(w, fmt.Sprintln("Request body was invalid."), http.StatusBadRequest)
		return
	}

	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not parse a userID (ID: %s)\n", userIDStr), http.StatusBadRequest)
		return
	}

	PostID, err := uuid.Parse(body.PostId)
	if err != nil {
		http.Error(w, fmt.Sprintf("Could not parse a PostId (ID: %s)\n", body.PostId), http.StatusBadRequest)
		return
	}

	query := `
		SELECT
			r.id IS NOT NULL AS is_parent_repost
		FROM users u
		LEFT JOIN reposts r ON r.id = $2
		WHERE u.id = $1
	`
	var isParentRepost bool
	err = h.db.QueryRow(query, userID, PostID).Scan(&isParentRepost)
	if err != nil {
		switch {
		case errors.Is(err, sql.ErrNoRows):
			http.Error(w, "User not found.", http.StatusBadRequest)
		default:
			http.Error(w, "Database query error.", http.StatusInternalServerError)
		}
		return
	}

	if isParentRepost {
		query = `INSERT INTO reposts (user_id, parent_repost_id, text) VALUES ($1, $2, $3) RETURNING id, created_at`
	} else {
		query = `INSERT INTO reposts (user_id, parent_post_id, text) VALUES ($1, $2, $3) RETURNING id, created_at`
	}

	var (
		id        uuid.UUID
		createdAt time.Time
	)

	text := ""

	err = h.db.QueryRow(query, userID, PostID, text).Scan(&id, &createdAt)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a repost."), http.StatusInternalServerError)
		return
	}

	repost := entities.Repost{
		ID:        id,
		ParentID:  PostID,
		UserID:    userID,
		Text:      text,
		CreatedAt: createdAt,
	}

	go func(userID uuid.UUID, userChan *map[string]chan entities.TimelineEvent) {
		var reposts []*entities.Repost
		reposts = append(reposts, &repost)
		query := `SELECT source_user_id FROM followships WHERE target_user_id = $1`
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
				userChan <- entities.TimelineEvent{EventType: entities.RepostCreated, Reposts: reposts}
			}
			h.mu.Unlock()
		}

	}(userID, h.usersChan)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(&repost)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
