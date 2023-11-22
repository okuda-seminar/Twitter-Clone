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
