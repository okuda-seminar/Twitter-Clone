package infrastructure

import (
	"database/sql"
	"time"
	"x-clone-backend/internal/app/errors"
	"x-clone-backend/internal/domain/entities"
	"x-clone-backend/internal/domain/repositories"

	"github.com/google/uuid"
)

type UsersRepository struct {
	DB *sql.DB
}

func NewUsersRepository(db *sql.DB) repositories.UsersRepositoryInterface {
	return &UsersRepository{db}
}

func (r *UsersRepository) WithTransaction(fn func(tx *sql.Tx) error) error {
	tx, err := r.DB.Begin()
	if err != nil {
		return err
	}
	if tx == nil {
		return nil
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

func (r *UsersRepository) CreateUser(tx *sql.Tx, username, displayName, password string) (entities.User, error) {
	query := `INSERT INTO users (username, display_name, password, bio, is_private) VALUES ($1, $2, $3, $4, $5)
        RETURNING id, created_at, updated_at`

	var (
		id                   uuid.UUID
		createdAt, updatedAt time.Time
	)

	var err error
	if tx != nil {
		err = tx.QueryRow(query, username, displayName, password, "", false).Scan(&id, &createdAt, &updatedAt)
	} else {
		err = r.DB.QueryRow(query, username, displayName, password, "", false).Scan(&id, &createdAt, &updatedAt)
	}
	if err != nil {
		return entities.User{}, err
	}

	user := entities.User{
		ID:          id,
		Username:    username,
		DisplayName: displayName,
		Bio:         "",
		IsPrivate:   false,
		CreatedAt:   createdAt,
		UpdatedAt:   updatedAt,
		Password:    password,
	}
	return user, nil
}

func (r *UsersRepository) DeleteUser(tx *sql.Tx, userID string) error {
	query := `DELETE FROM users WHERE id = $1`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, userID)
	} else {
		res, err = r.DB.Exec(query, userID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.ErrUserNotFound
	}

	return nil
}

func (r *UsersRepository) GetSpecificUser(tx *sql.Tx, userID string) (entities.User, error) {
	query := `SELECT * FROM users WHERE id = $1`
	var row *sql.Row
	if tx != nil {
		row = tx.QueryRow(query, userID)
	} else {
		row = r.DB.QueryRow(query, userID)
	}

	var user entities.User
	err := row.Scan(
		&user.ID,
		&user.Username,
		&user.DisplayName,
		&user.Bio,
		&user.IsPrivate,
		&user.CreatedAt,
		&user.UpdatedAt,
		&user.Password,
	)
	return user, err
}

func (r *UsersRepository) UserByUsername(tx *sql.Tx, username string) (entities.User, error) {
	query := `SELECT * FROM users WHERE username = $1`
	var row *sql.Row
	if tx != nil {
		row = tx.QueryRow(query, username)
	} else {
		row = r.DB.QueryRow(query, username)
	}

	var user entities.User
	err := row.Scan(
		&user.ID,
		&user.Username,
		&user.DisplayName,
		&user.Bio,
		&user.IsPrivate,
		&user.CreatedAt,
		&user.UpdatedAt,
		&user.Password,
	)
	return user, err
}

func (r *UsersRepository) LikePost(tx *sql.Tx, userID string, postID uuid.UUID) error {
	query := "INSERT INTO likes (user_id, post_id) VALUES ($1, $2)"

	var err error
	if tx != nil {
		_, err = tx.Exec(query, userID, postID)
	} else {
		_, err = r.DB.Exec(query, userID, postID)
	}
	return err
}

func (r *UsersRepository) UnlikePost(tx *sql.Tx, userID string, postID string) error {
	query := "DELETE FROM likes WHERE user_id = $1 AND post_id = $2"
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, userID, postID)
	} else {
		res, err = r.DB.Exec(query, userID, postID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.ErrLikeNotFound
	}

	return nil
}

func (r *UsersRepository) FollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `INSERT INTO followships (source_user_id, target_user_id) VALUES ($1, $2)`

	var err error
	if tx != nil {
		_, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		_, err = r.DB.Exec(query, sourceUserID, targetUserID)
	}
	return err
}

func (r *UsersRepository) UnfollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `DELETE FROM followships WHERE source_user_id = $1 AND target_user_id = $2`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		res, err = r.DB.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.ErrFollowshipNotFound
	}

	return nil
}

func (r *UsersRepository) MuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `INSERT INTO mutes (source_user_id, target_user_id) VALUES ($1, $2)`

	var err error
	if tx != nil {
		_, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		_, err = r.DB.Exec(query, sourceUserID, targetUserID)
	}
	return err
}

func (r *UsersRepository) UnmuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `DELETE FROM mutes WHERE source_user_id = $1 AND target_user_id = $2`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		res, err = r.DB.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.ErrMuteNotFound
	}

	return nil
}

func (r *UsersRepository) BlockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `INSERT INTO blocks (source_user_id, target_user_id) VALUES ($1, $2)`
	var err error
	if tx != nil {
		_, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		_, err = r.DB.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}

	return nil
}

func (r *UsersRepository) UnblockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `DELETE FROM blocks WHERE source_user_id = $1 AND target_user_id = $2`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		res, err = r.DB.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return errors.ErrBlockNotFound
	}

	return nil
}
