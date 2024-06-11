package repository

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/google/uuid"
)

// usersRepoImpl implements users/db/repository/usersRepo.
type usersRepoImpl struct {
	db *sql.DB
}

// NewUsersRepoImpl returns the users repository implementation.
func NewUsersRepoImpl(db *sql.DB) UsersRepo {
	return &usersRepoImpl{db}
}

// CreateUser creates a new user with the specified username.
// The 'Bio' field is set to an empty string, not null.
// If a user with the specified username already exists, the creation fails.
func (r *usersRepoImpl) CreateUser(ctx context.Context, username string, display_name string,
) (*User, error) {
	query := `
INSERT INTO users (id, username, display_name, bio) VALUES ($1, $2, $3, $4)
RETURNING created_at, updated_at
`
	var createdAt, updatedAt time.Time
	id := uuid.New()

	err := r.db.QueryRowContext(ctx, query, id, username, display_name, "").
		Scan(&createdAt, &updatedAt)
	if err != nil {
		return nil, err
	}

	user := User{
		ID:          id,
		Username:    username,
		DisplayName: display_name,
		Bio:         "",
		CreatedAt:   createdAt,
		UpdatedAt:   updatedAt,
	}
	return &user, nil
}

// DeleteUser deletes a user with the specified user ID.
func (r *usersRepoImpl) DeleteUser(ctx context.Context, id uuid.UUID) error {
	query := "DELETE FROM users WHERE id = $1"
	res, err := r.db.ExecContext(ctx, query, id)
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.New("no row found to delete")
	}

	return nil
}

// FindUserByID retrieves a user by user ID from the database.
func (r *usersRepoImpl) FindUserByID(ctx context.Context, id uuid.UUID) (*User, error) {
	query := "SELECT * FROM users WHERE id = $1"
	row := r.db.QueryRowContext(ctx, query, id)

	var user User

	err := row.Scan(
		&user.ID,
		&user.Username,
		&user.DisplayName,
		&user.Bio,
		&user.CreatedAt,
		&user.UpdatedAt,
	)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

// UpdateUsername updates the username of a user with the specified ID.
// If a user with the specified username already exists, the update fails.
func (r *usersRepoImpl) UpdateUsername(ctx context.Context, id uuid.UUID, username string) error {
	query := "UPDATE users SET username = $1 where id = $2"
	res, err := r.db.ExecContext(ctx, query, username, id)
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.New("no row found to update")
	}

	return nil
}

// UpdateBio updates the bio of a user with the specified ID.
func (r *usersRepoImpl) UpdateBio(ctx context.Context, id uuid.UUID, bio string) error {
	query := "UPDATE users SET bio = $1 where id = $2"
	res, err := r.db.ExecContext(ctx, query, bio, id)
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.New("no row found to update")
	}

	return nil
}

// GetFollowers retrieves all the followers of a user with the specified ID.
func (r *usersRepoImpl) GetFollowers(ctx context.Context, id uuid.UUID) ([]*User, error) {
	query := `
SELECT * FROM users
JOIN followships ON users.id = followships.followed_user_id
WHERE followships.following_user_id = $1
`
	rows, err := r.db.QueryContext(ctx, query, id)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var followers []*User
	for rows.Next() {
		var user User
		err := rows.Scan(
			&user.ID,
			&user.Username,
			&user.DisplayName,
			&user.Bio,
			&user.CreatedAt,
			&user.UpdatedAt,
			// ignore follower_id and followee_id.
			IgnoreColumn,
			IgnoreColumn,
		)
		if err != nil {
			return nil, err
		}
		followers = append(followers, &user)
	}

	return followers, nil
}

// GetFollowings retrieves all the followings of a user with the specified ID.
func (r *usersRepoImpl) GetFollowings(ctx context.Context, id uuid.UUID) ([]*User, error) {
	query := `
SELECT * FROM users
JOIN followships ON users.id = followships.following_user_id
WHERE followships.followed_user_id = $1
`
	rows, err := r.db.QueryContext(ctx, query, id)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var followings []*User
	for rows.Next() {
		var user User
		err := rows.Scan(
			&user.ID,
			&user.Username,
			&user.DisplayName,
			&user.Bio,
			&user.CreatedAt,
			&user.UpdatedAt,
			// ignore follower_id and followee_id.
			IgnoreColumn,
			IgnoreColumn,
		)
		if err != nil {
			return nil, err
		}
		followings = append(followings, &user)
	}

	return followings, nil
}

var IgnoreColumn ignoreColumn

// ignoreColumn provides a mechanism for ignoring unnecessary columns
// when scanning rows from a database query result in Go.
// The `Scan` method, invoked by `Rows.Scan`, performs no action and returns nil,
// effectively ignoring the column value.
type ignoreColumn struct{}

func (ignoreColumn) Scan(value any) error {
	return nil
}
