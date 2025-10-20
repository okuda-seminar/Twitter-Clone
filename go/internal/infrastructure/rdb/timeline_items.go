package rdb

import (
	"database/sql"
	"errors"
	"time"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/domain/value"
)

type RDBTimelineItemsRepository struct {
	db *sql.DB
}

func NewRDBTimelineItemsRepository(db *sql.DB) RDBTimelineItemsRepository {
	return RDBTimelineItemsRepository{db}
}

func (r *RDBTimelineItemsRepository) WithTransaction(fn func(tx *sql.Tx) error) error {
	tx, err := r.db.Begin()
	if err != nil {
		return err
	}

	defer func() {
		if r := recover(); r != nil {
			tx.Rollback()
		} else if err != nil {
			tx.Rollback()
		} else {
			err = tx.Commit()
		}
	}()

	err = fn(tx)
	return err
}

func (r *RDBTimelineItemsRepository) SpecificUserPosts(userID string) ([]*entity.TimelineItem, error) {
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
func (r *RDBTimelineItemsRepository) UserAndFolloweePosts(userID string) ([]*entity.TimelineItem, error) {
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
func (r *RDBTimelineItemsRepository) CreatePost(tx *sql.Tx, userID, text string) (entity.TimelineItem, error) {
	query := `INSERT INTO timelineitems (type, author_id, text) VALUES ($1, $2, $3) RETURNING id, created_at`

	var (
		id        string
		createdAt time.Time
	)

	postType := entity.PostTypePost

	var err error
	if tx == nil {
		err = r.db.QueryRow(query, postType, userID, text).Scan(&id, &createdAt)
	} else {
		err = tx.QueryRow(query, postType, userID, text).Scan(&id, &createdAt)
	}
	if err != nil {
		if isForeignKeyError(err) {
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

func (r *RDBTimelineItemsRepository) DeletePost(postID string) (entity.TimelineItem, error) {
	query := `DELETE FROM timelineitems WHERE id = $1 RETURNING author_id, text, created_at`

	var (
		authorID  string
		text      string
		createdAt time.Time
	)

	err := r.db.QueryRow(query, postID).Scan(&authorID, &text, &createdAt)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return entity.TimelineItem{}, repository.ErrRecordNotFound
		}
		return entity.TimelineItem{}, err
	}

	post := entity.TimelineItem{
		Type:      entity.PostTypePost,
		ID:        postID,
		AuthorID:  authorID,
		Text:      text,
		CreatedAt: createdAt,
	}

	return post, nil
}

func (r *RDBTimelineItemsRepository) CreateRepost(tx *sql.Tx, userID, postID string) (entity.TimelineItem, error) {
	query := `INSERT INTO timelineitems (type, author_id, parent_post_id, text) VALUES ($1, $2, $3, $4) RETURNING id, created_at`

	var (
		id        string
		createdAt time.Time
	)

	postType := entity.PostTypeRepost
	text := ""

	var err error
	if tx == nil {
		err = r.db.QueryRow(query, postType, userID, postID, text).Scan(&id, &createdAt)
	} else {
		err = tx.QueryRow(query, postType, userID, postID, text).Scan(&id, &createdAt)
	}
	if err != nil {
		if isForeignKeyError(err) {
			return entity.TimelineItem{}, repository.ErrForeignViolation
		}
		return entity.TimelineItem{}, err
	}

	repost := entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: postID, Valid: true},
		Text:         text,
		CreatedAt:    createdAt,
	}

	return repost, nil
}

func (r *RDBTimelineItemsRepository) DeleteRepost(postID string) (entity.TimelineItem, error) {
	query := `DELETE FROM timelineitems WHERE id = $1 RETURNING author_id, parent_post_id, created_at`

	var (
		authorID     string
		parentPostID sql.NullString
		createdAt    time.Time
	)

	err := r.db.QueryRow(query, postID).Scan(&authorID, &parentPostID, &createdAt)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return entity.TimelineItem{}, repository.ErrRecordNotFound
		}
		return entity.TimelineItem{}, err
	}

	repost := entity.TimelineItem{
		Type:         entity.PostTypeRepost,
		ID:           postID,
		AuthorID:     authorID,
		ParentPostID: value.NullUUID{UUID: parentPostID.String, Valid: parentPostID.Valid},
		Text:         "",
		CreatedAt:    createdAt,
	}

	return repost, nil
}

// CreateQuoteRepost creates and returns a new quote repost by the given userID with the provided text.
// This method does not handle
func (r *RDBTimelineItemsRepository) CreateQuoteRepost(tx *sql.Tx, userID, postID, text string) (entity.TimelineItem, error) {
	query := `INSERT INTO timelineitems (type, author_id, parent_post_id ,text) VALUES ($1, $2, $3, $4) RETURNING id, created_at`

	var (
		id        string
		createdAt time.Time
	)

	postType := entity.PostTypeQuoteRepost

	var err error
	if tx == nil {
		err = r.db.QueryRow(query, postType, userID, postID, text).Scan(&id, &createdAt)
	} else {
		err = tx.QueryRow(query, postType, userID, postID, text).Scan(&id, &createdAt)
	}
	if err != nil {
		if isForeignKeyError(err) {
			return entity.TimelineItem{}, repository.ErrForeignViolation
		}
		return entity.TimelineItem{}, err
	}

	quoteRepost := entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: postID, Valid: true},
		Text:         text,
		CreatedAt:    createdAt,
	}

	return quoteRepost, nil
}

func (r *RDBTimelineItemsRepository) TimelineItemByID(postID string) (*entity.TimelineItem, error) {
	query := `SELECT * FROM timelineitems WHERE id = $1`

	var (
		id           string
		postType     string
		authorID     string
		parentPostID value.NullUUID
		text         string
		createdAt    time.Time
	)

	err := r.db.QueryRow(query, postID).Scan(&id, &postType, &authorID, &parentPostID, &text, &createdAt)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, repository.ErrRecordNotFound
		}
		return nil, err
	}

	item := &entity.TimelineItem{
		Type:         postType,
		ID:           id,
		AuthorID:     authorID,
		ParentPostID: parentPostID,
		Text:         text,
		CreatedAt:    createdAt,
	}

	return item, nil
}
