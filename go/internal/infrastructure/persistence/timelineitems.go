package persistence

import (
	"database/sql"
	"time"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"

	"github.com/google/uuid"
)

type timelineitemsRepository struct {
	db *sql.DB
}

func NewTimelineitemsRepository(db *sql.DB) repository.TimelineItemsRepository {
	return &timelineitemsRepository{db}
}

func (r *timelineitemsRepository) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	query := `SELECT * FROM timelineitems WHERE author_id = $1`

	rows, err := r.db.Query(query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var timelineitems []*entity.TimelineItem
	for rows.Next() {
		var (
			id             uuid.UUID
			postType       string
			author_id      uuid.UUID
			parent_post_id uuid.NullUUID
			text           string
			created_at     time.Time
		)
		if err := rows.Scan(&id, &postType, &author_id, &parent_post_id, &text, &created_at); err != nil {
			return nil, err
		}

		timelineitem := entity.TimelineItem{
			Type:         postType,
			ID:           id,
			AuthorID:     author_id,
			ParentPostID: parent_post_id,
			Text:         text,
			CreatedAt:    created_at,
		}
		timelineitems = append(timelineitems, &timelineitem)
	}

	return timelineitems, nil
}

func (r *timelineitemsRepository) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
	query := `
		SELECT timelineitems.* 
		FROM timelineitems
		LEFT JOIN followships ON timelineitems.author_id = followships.target_user_id
		WHERE followships.source_user_id = $1
		OR timelineitems.author_id = $1
		ORDER BY timelineitems.created_at DESC
	`
	rows, err := r.db.Query(query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var timelineitems []*entity.TimelineItem
	for rows.Next() {
		var (
			id             uuid.UUID
			postType       string
			author_id      uuid.UUID
			parent_post_id uuid.NullUUID
			text           string
			created_at     time.Time
		)
		if err := rows.Scan(&id, &postType, &author_id, &parent_post_id, &text, &created_at); err != nil {
			return nil, err
		}

		timelineitem := entity.TimelineItem{
			Type:         postType,
			ID:           id,
			AuthorID:     author_id,
			ParentPostID: parent_post_id,
			Text:         text,
			CreatedAt:    created_at,
		}
		timelineitems = append(timelineitems, &timelineitem)
	}

	return timelineitems, nil
}
