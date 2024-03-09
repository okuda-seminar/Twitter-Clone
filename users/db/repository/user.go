package repository

import (
	"context"
	"errors"
)

// CreateUser creates a new user with the specified username.
// The 'Bio' field is set to an empty string, not null.
// If a user with the specified username already exists, the creation fails.
func (r *repository) CreateUser(ctx context.Context, username string) (*User, error) {
	query := "INSERT INTO users (username, bio) VALUES ($1, $2) RETURNING id"
	var id int
	err := r.db.QueryRowContext(ctx, query, username, "").Scan(&id)
	if err != nil {
		return nil, err
	}

	user := User{
		ID:       id,
		Username: username,
		Bio:      "",
	}
	return &user, nil
}

// DeleteUser deletes a user with the specified ID.
func (r *repository) DeleteUser(ctx context.Context, id int) error {
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

// FindUserByID retrieves a user by ID from the database.
func (r *repository) FindUserByID(ctx context.Context, id int) (*User, error) {
	query := "SELECT * FROM users WHERE id = $1"
	row := r.db.QueryRowContext(ctx, query, id)

	var user User

	err := row.Scan(
		&user.ID,
		&user.Username,
		&user.Bio,
	)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

// UpdateUsername updates the username of a user with the specified ID.
// If a user with the specified username already exists, the update fails.
func (r *repository) UpdateUsername(ctx context.Context, id int, username string) error {
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
func (r *repository) UpdateBio(ctx context.Context, id int, bio string) error {
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
func (r *repository) GetFollowers(ctx context.Context, id int) ([]*User, error) {
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
			&user.ID,
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
func (r *repository) GetFollowees(ctx context.Context, id int) ([]*User, error) {
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
			&user.ID,
			&user.Username,
		)
		if err != nil {
			return nil, err
		}
		followees = append(followees, &user)
	}

	return followees, nil
}
