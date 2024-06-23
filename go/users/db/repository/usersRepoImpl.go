package repository

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"strings"
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

func (r *usersRepoImpl) CreateUser(ctx context.Context, username string, display_name string, is_private bool) (*User, error) {
	query := `
INSERT INTO users (id, username, display_name, bio, is_private) VALUES ($1, $2, $3, $4, $5)
RETURNING created_at, updated_at
`
	var createdAt, updatedAt time.Time
	id := uuid.New()

	err := r.db.QueryRowContext(ctx, query, id, username, display_name, "", is_private).
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
		IsPrivate:   is_private,
	}
	return &user, nil
}

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

func (r *usersRepoImpl) FindUserByID(ctx context.Context, id uuid.UUID) (*User, error) {
	query := "SELECT id, username, display_name, bio, created_at, updated_at, is_private FROM users WHERE id = $1"
	row := r.db.QueryRowContext(ctx, query, id)

	var user User

	err := row.Scan(
		&user.ID,
		&user.Username,
		&user.DisplayName,
		&user.Bio,
		&user.CreatedAt,
		&user.UpdatedAt,
		&user.IsPrivate,
	)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *usersRepoImpl) UpdateProfile(ctx context.Context, id uuid.UUID, fields map[string]any) error {
	if len(fields) == 0 {
		return errors.New("no fields to update")
	}

	var clauses []string
	var args []any
	i := 1 // placeholder count
	for field, value := range fields {
		clauses = append(clauses, fmt.Sprintf("%s = $%d", field, i))
		args = append(args, value)
		i += 1
	}
	args = append(args, id)

	query := fmt.Sprintf("UPDATE users SET %s WHERE id = $%d", strings.Join(clauses, ", "), i)

	res, err := r.db.ExecContext(ctx, query, args...)
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

func (r *usersRepoImpl) GetFollowers(ctx context.Context, id uuid.UUID) ([]*User, error) {
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
			&user.IsPrivate,
			// ignore followed_user_id and following_user_id.
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

func (r *usersRepoImpl) GetFollowings(ctx context.Context, id uuid.UUID) ([]*User, error) {
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
			&user.IsPrivate,
			// ignore followed_user_id and following_user_id.
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
