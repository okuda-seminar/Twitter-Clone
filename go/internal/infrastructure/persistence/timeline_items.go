package persistence

import (
	"database/sql"
	"time"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/domain/value"
)

type timelineItemsRepository struct {
	db *sql.DB
}

func NewTimelineitemsRepository(db *sql.DB) repository.TimelineItemsRepository {
	return &timelineItemsRepository{db}
}

func (r *timelineItemsRepository) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
	query := `SELECT * FROM timelineitems WHERE author_id = $1`

	rows, err := r.db.Query(query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var timelineitems []*entity.TimelineItem
	for rows.Next() {
		var (
			id             string
			postType       string
			author_id      string
			parent_post_id value.NullUUID
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

// This method does not use the userID argument and gets all the timelineitems in the fake repository.
// This is to avoid timelineItems having information in the follow table.
func (r *timelineItemsRepository) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
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
			id             string
			postType       string
			author_id      string
			parent_post_id value.NullUUID
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

// CreatePost creates and returns a new post by the given userID with the provided text.
func (r *timelineItemsRepository) CreatePost(userID, text string) (entity.TimelineItem, error) {
	query := `INSERT INTO timelineitems (type, author_id, text) VALUES ($1, $2, $3) RETURNING id, created_at`

	var (
		id        string
		createdAt time.Time
	)

	postType := entity.PostTypePost

	err := r.db.QueryRow(query, postType, userID, text).Scan(&id, &createdAt)
	if err != nil {
		if IsForeignKeyError(err) {
			return entity.TimelineItem{}, repository.ErrForeignViolation
		}
		return entity.TimelineItem{}, err
	}

	post := entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{},
		Text:         text,
		CreatedAt:    createdAt,
	}
	return post, nil
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/679
// - Refactor DeletePost
func (r *timelineItemsRepository) DeletePost(postID string) error {
	return nil
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/680
// - Refactor CreateRepost
func (r *timelineItemsRepository) CreateRepost(userID, postID string) (entity.TimelineItem, error) {
	return entity.TimelineItem{}, nil
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/681
// - Refactor DeleteRepost
func (r *timelineItemsRepository) DeleteRepost(postID string) error {
	return nil
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/682
// - Refactor CreateQuoteRepost
func (r *timelineItemsRepository) CreateQuoteRepost(userID, postID, text string) (entity.TimelineItem, error) {
	return entity.TimelineItem{}, nil
}

// These methods are only used in the fake implementation for testing and are unused here.
func (r *timelineItemsRepository) SetError(key string, err error) {}
func (r *timelineItemsRepository) ClearError(key string)          {}
