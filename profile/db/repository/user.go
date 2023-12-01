package repository

import (
	"context"
)

// FindByID retrieves a user by ID from the database.
func (r *repository) FindByID(ctx context.Context, id int) (*User, error) {
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
func (r *repository) UpdateUsername(ctx context.Context, id int, username string) error {
	query := "UPDATE users SET username = $1 where id = $2"
	_, err := r.db.ExecContext(ctx, query, username, id)
	if err != nil {
		return err
	}

	return nil
}

// UpdateBio updates the bio of a user with the specified ID.
func (r *repository) UpdateBio(ctx context.Context, id int, bio string) error {
	query := "UPDATE users SET bio = $1 where id = $2"
	_, err := r.db.ExecContext(ctx, query, bio, id)
	if err != nil {
		return err
	}

	return nil
}
