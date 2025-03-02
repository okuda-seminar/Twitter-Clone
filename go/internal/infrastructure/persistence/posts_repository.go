package infrastructure

import (
	"database/sql"
	"time"
	"x-clone-backend/internal/domain/entities"
	"x-clone-backend/internal/domain/repositories"

	"github.com/google/uuid"
)

type PostsRepository struct {
	DB *sql.DB
}

func NewPostsRepository(db *sql.DB) repositories.PostsRepositoryInterface {
	return &PostsRepository{db}
}

func (r *PostsRepository) GetSpecificUserPosts(userID string) ([]*entities.Post, error) {
	query := `SELECT * FROM posts WHERE user_id = $1`

	rows, err := r.DB.Query(query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var posts []*entities.Post
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

		post := entities.Post{
			ID:        id,
			UserID:    user_id,
			Text:      text,
			CreatedAt: created_at,
		}
		posts = append(posts, &post)
	}

	return posts, nil
}

func (r *PostsRepository) GetUserAndFolloweePosts(userID string) ([]*entities.Post, error) {
	query := `
		SELECT posts.* 
		FROM posts
		LEFT JOIN followships ON posts.user_id = followships.target_user_id
		WHERE followships.source_user_id = $1
		OR posts.user_id = $1
		ORDER BY posts.created_at DESC
	`
	rows, err := r.DB.Query(query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var posts []*entities.Post
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

		post := entities.Post{
			ID:        id,
			UserID:    user_id,
			Text:      text,
			CreatedAt: created_at,
		}
		posts = append(posts, &post)
	}

	return posts, nil
}
