package persistence

import (
	"database/sql"
	"time"

	"github.com/google/uuid"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type postsRepository struct {
	db *sql.DB
}

func NewPostsRepository(db *sql.DB) repository.PostsRepository {
	return &postsRepository{db}
}

func (r *postsRepository) GetSpecificUserPosts(userID string) ([]*entity.Post, error) {
	query := `SELECT * FROM posts WHERE user_id = $1`

	rows, err := r.db.Query(query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var posts []*entity.Post
	for rows.Next() {
		var (
			id         uuid.UUID
			user_id    uuid.UUID
			text       string
			created_at time.Time
		)
		if err := rows.Scan(&id, &user_id, &text, &created_at); err != nil {
			return nil, err
		}

		post := entity.Post{
			ID:        id,
			UserID:    user_id,
			Text:      text,
			CreatedAt: created_at,
		}
		posts = append(posts, &post)
	}

	return posts, nil
}

func (r *postsRepository) GetUserAndFolloweePosts(userID string) ([]*entity.Post, error) {
	query := `
		SELECT posts.* 
		FROM posts
		LEFT JOIN followships ON posts.user_id = followships.target_user_id
		WHERE followships.source_user_id = $1
		OR posts.user_id = $1
		ORDER BY posts.created_at DESC
	`
	rows, err := r.db.Query(query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var posts []*entity.Post
	for rows.Next() {
		var (
			id         uuid.UUID
			user_id    uuid.UUID
			text       string
			created_at time.Time
		)
		if err := rows.Scan(&id, &user_id, &text, &created_at); err != nil {
			return nil, err
		}

		post := entity.Post{
			ID:        id,
			UserID:    user_id,
			Text:      text,
			CreatedAt: created_at,
		}
		posts = append(posts, &post)
	}

	return posts, nil
}
