package repository

import (
	"context"
	"database/sql"
	"errors"
	"time"
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
func (r *usersRepoImpl) CreateUser(ctx context.Context, username string) (*User, error) {
	query := `
INSERT INTO users (username, bio) VALUES ($1, $2)
RETURNING user_id, created_at, updated_at
`
	var (
		userId               int
		createdAt, updatedAt time.Time
	)

	err := r.db.QueryRowContext(ctx, query, username, "").Scan(&userId, &createdAt, &updatedAt)
	if err != nil {
		return nil, err
	}

	user := User{
		UserID:    userId,
		Username:  username,
		Bio:       "",
		CreatedAt: createdAt,
		UpdatedAt: updatedAt,
	}
	return &user, nil
}

// DeleteUser deletes a user with the specified user ID.
func (r *usersRepoImpl) DeleteUser(ctx context.Context, user_id int) error {
	query := "DELETE FROM users WHERE user_id = $1"
	res, err := r.db.ExecContext(ctx, query, user_id)
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
func (r *usersRepoImpl) FindUserByID(ctx context.Context, user_id int) (*User, error) {
	query := "SELECT * FROM users WHERE user_id = $1"
	row := r.db.QueryRowContext(ctx, query, user_id)

	var user User

	err := row.Scan(
		&user.UserID,
		&user.Username,
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
func (r *usersRepoImpl) UpdateUsername(ctx context.Context, user_id int, username string) error {
	query := "UPDATE users SET username = $1 where user_id = $2"
	res, err := r.db.ExecContext(ctx, query, username, user_id)
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
func (r *usersRepoImpl) UpdateBio(ctx context.Context, user_id int, bio string) error {
	query := "UPDATE users SET bio = $1 where user_id = $2"
	res, err := r.db.ExecContext(ctx, query, bio, user_id)
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
func (r *usersRepoImpl) GetFollowers(ctx context.Context, id int) ([]*User, error) {
	query := `
		SELECT *
		FROM users
		JOIN follows ON users.id = follows.follower_id
		WHERE follows.followee_id = $1
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
			&user.UserID,
			&user.Username,
		)
		if err != nil {
			return nil, err
		}
		followers = append(followers, &user)
	}

	return followers, nil
}

// GetFollowees retrieves all the followees of a user with the specified ID.
func (r *usersRepoImpl) GetFollowees(ctx context.Context, id int) ([]*User, error) {
	query := `
		SELECT *
		FROM users
		JOIN follows ON users.id = follows.followee_id
		WHERE follows.follower_id = $1
	`
	rows, err := r.db.QueryContext(ctx, query, id)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var followees []*User
	for rows.Next() {
		var user User
		err := rows.Scan(
			&user.UserID,
			&user.Username,
		)
		if err != nil {
			return nil, err
		}
		followees = append(followees, &user)
	}

	return followees, nil
}
