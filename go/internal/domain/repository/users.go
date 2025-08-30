package repository

import (
	"database/sql"

	"x-clone-backend/internal/domain/entity"
)

type UsersRepository interface {
	WithTransaction(fn func(tx *sql.Tx) error) error

	CreateUser(tx *sql.Tx, username, displayName, password string) (entity.User, error)
	DeleteUserByID(tx *sql.Tx, userID string) error
	UserByUserID(tx *sql.Tx, userID string) (entity.User, error)
	UserByUsername(tx *sql.Tx, userName string) (entity.User, error)
	LikePost(tx *sql.Tx, userID, postID string) error
	UnlikePost(tx *sql.Tx, userID, postID string) error
	FollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	UnfollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	GetFolloweesByID(tx *sql.Tx, targetUserID string) ([]entity.User, error)
	MuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	UnmuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	BlockUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	UnblockUser(tx *sql.Tx, sourceUserID, targetUserID string) error

	SetError(key string, err error)
	ClearError(key string)
}
