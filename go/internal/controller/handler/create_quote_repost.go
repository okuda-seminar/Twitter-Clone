package handler

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"

	"github.com/google/uuid"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/value"
	"x-clone-backend/internal/openapi"
)

type CreateQuoteRepostHandler struct {
	db        *sql.DB
	mu        *sync.Mutex
	usersChan *map[string]chan entity.TimelineEvent
}

func NewCreateQuoteRepostHandler(db *sql.DB, mu *sync.Mutex, usersChan *map[string]chan entity.TimelineEvent) CreateQuoteRepostHandler {
	return CreateQuoteRepostHandler{
		db:        db,
		mu:        mu,
		usersChan: usersChan,
	}
}

// CreateQuoteRepost creates a new quote repost with the specified post_id and user_id,
// then, inserts it into reposts table.
func (h *CreateQuoteRepostHandler) CreateQuoteRepost(w http.ResponseWriter, r *http.Request, userIDStr string) {
	var body openapi.CreateQuoteRepostRequest

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

	query := `INSERT INTO timelineitems (type, author_id, parent_post_id ,text) VALUES ($1, $2, $3, $4) RETURNING id, created_at`

	var (
		id        uuid.UUID
		createdAt time.Time
	)

	postType := entity.PostTypeQuoteRepost

	err = h.db.QueryRow(query, postType, userID, PostID, body.Text).Scan(&id, &createdAt)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not create a quote repost."), http.StatusInternalServerError)
		return
	}

	quoteRepost := entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: PostID, Valid: true},
		Text:         body.Text,
		CreatedAt:    createdAt,
	}

	go func(userID uuid.UUID, userChan *map[string]chan entity.TimelineEvent) {
		var quoteReposts []*entity.TimelineItem
		quoteReposts = append(quoteReposts, &quoteRepost)
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
				userChan <- entity.TimelineEvent{EventType: entity.QuoteRepostCreated, TimelineItems: quoteReposts}
			}
			h.mu.Unlock()
		}

	}(userID, h.usersChan)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	encoder := json.NewEncoder(w)
	err = encoder.Encode(&quoteRepost)
	if err != nil {
		http.Error(w, fmt.Sprintln("Could not encode response."), http.StatusInternalServerError)
		return
	}
}
