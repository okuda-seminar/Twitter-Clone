package implementation

import (
	"database/sql"
	"errors"
	"time"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type usersRepository struct {
	db *sql.DB
}

func NewUsersRepository(db *sql.DB) repository.UsersRepository {
	return &usersRepository{db}
}

func (r *usersRepository) WithTransaction(fn func(tx *sql.Tx) error) error {
	tx, err := r.db.Begin()
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

func (r *usersRepository) CreateUser(tx *sql.Tx, username, displayName, password string) (entity.User, error) {
	query := `INSERT INTO users (username, display_name, password, bio, is_private) VALUES ($1, $2, $3, $4, $5)
        RETURNING id, created_at, updated_at`

	var (
		id                   string
		createdAt, updatedAt time.Time
	)

	var err error
	if tx != nil {
		err = tx.QueryRow(query, username, displayName, password, "", false).Scan(&id, &createdAt, &updatedAt)
	} else {
		err = r.db.QueryRow(query, username, displayName, password, "", false).Scan(&id, &createdAt, &updatedAt)
	}
	if err != nil {
		if isUniqueViolationError(err) {
			return entity.User{}, repository.ErrUniqueViolation
		}

		return entity.User{}, err
	}

	user := entity.User{
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

func (r *usersRepository) DeleteUserByID(tx *sql.Tx, userID string) error {
	query := `DELETE FROM users WHERE id = $1`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, userID)
	} else {
		res, err = r.db.Exec(query, userID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return repository.ErrRecordNotFound
	}

	return nil
}

func (r *usersRepository) UserByUserID(tx *sql.Tx, userID string) (entity.User, error) {
	query := `SELECT * FROM users WHERE id = $1`
	var row *sql.Row
	if tx != nil {
		row = tx.QueryRow(query, userID)
	} else {
		row = r.db.QueryRow(query, userID)
	}

	var user entity.User
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
	if errors.Is(err, sql.ErrNoRows) {
		return entity.User{}, repository.ErrRecordNotFound
	}

	return user, err
}

func (r *usersRepository) UserByUsername(tx *sql.Tx, username string) (entity.User, error) {
	query := `SELECT * FROM users WHERE username = $1`
	var row *sql.Row
	if tx != nil {
		row = tx.QueryRow(query, username)
	} else {
		row = r.db.QueryRow(query, username)
	}

	var user entity.User
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
	if errors.Is(err, sql.ErrNoRows) {
		return entity.User{}, repository.ErrRecordNotFound
	}

	return user, err
}

func (r *usersRepository) LikePost(tx *sql.Tx, userID string, postID string) error {
	query := "INSERT INTO likes (user_id, post_id) VALUES ($1, $2)"

	var err error
	if tx != nil {
		_, err = tx.Exec(query, userID, postID)
	} else {
		_, err = r.db.Exec(query, userID, postID)
	}
	return err
}

func (r *usersRepository) UnlikePost(tx *sql.Tx, userID string, postID string) error {
	query := "DELETE FROM likes WHERE user_id = $1 AND post_id = $2"
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, userID, postID)
	} else {
		res, err = r.db.Exec(query, userID, postID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return repository.ErrRecordNotFound
	}

	return nil
}

func (r *usersRepository) FollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `INSERT INTO followships (source_user_id, target_user_id) VALUES ($1, $2)`

	var err error
	if tx != nil {
		_, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		_, err = r.db.Exec(query, sourceUserID, targetUserID)
	}
	return err
}

func (r *usersRepository) UnfollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `DELETE FROM followships WHERE source_user_id = $1 AND target_user_id = $2`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		res, err = r.db.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return repository.ErrRecordNotFound
	}

	return nil
}

func (r *usersRepository) GetFolloweesByID(tx *sql.Tx, targetUserID string) ([]entity.User, error) {
	query := `
		SELECT u.id, u.username, u.display_name, u.bio, u.is_private, u.created_at, u.updated_at 
		FROM users u 
		INNER JOIN followships f ON u.id = f.source_user_id 
		WHERE f.target_user_id = $1
	`
	var rows *sql.Rows
	var err error
	if tx != nil {
		rows, err = tx.Query(query, targetUserID)
	} else {
		rows, err = r.db.Query(query, targetUserID)
	}
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []entity.User
	for rows.Next() {
		var user entity.User
		if err := rows.Scan(
			&user.ID,
			&user.Username,
			&user.DisplayName,
			&user.Bio,
			&user.IsPrivate,
			&user.CreatedAt,
			&user.UpdatedAt,
		); err != nil {
			return nil, err
		}
		users = append(users, user)
	}

	return users, rows.Err()
}

func (r *usersRepository) MuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `INSERT INTO mutes (source_user_id, target_user_id) VALUES ($1, $2)`

	var err error
	if tx != nil {
		_, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		_, err = r.db.Exec(query, sourceUserID, targetUserID)
	}
	return err
}

func (r *usersRepository) UnmuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `DELETE FROM mutes WHERE source_user_id = $1 AND target_user_id = $2`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		res, err = r.db.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return repository.ErrRecordNotFound
	}

	return nil
}

func (r *usersRepository) BlockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `INSERT INTO blocks (source_user_id, target_user_id) VALUES ($1, $2)`
	var err error
	if tx != nil {
		_, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		_, err = r.db.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}

	return nil
}

func (r *usersRepository) UnblockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	query := `DELETE FROM blocks WHERE source_user_id = $1 AND target_user_id = $2`
	var res sql.Result
	var err error
	if tx != nil {
		res, err = tx.Exec(query, sourceUserID, targetUserID)
	} else {
		res, err = r.db.Exec(query, sourceUserID, targetUserID)
	}
	if err != nil {
		return err
	}
	count, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if count != 1 {
		return repository.ErrRecordNotFound
	}

	return nil
}

func (r *usersRepository) SetError(key string, err error) {}
func (r *usersRepository) ClearError(key string)          {}
