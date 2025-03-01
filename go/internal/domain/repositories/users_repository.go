package repositories

import (
	"database/sql"
	"x-clone-backend/internal/domain/entities"

	"github.com/google/uuid"
)

type UsersRepositoryInterface interface {
	WithTransaction(fn func(tx *sql.Tx) error) error

	CreateUser(tx *sql.Tx, username, displayName, password string) (entities.User, error)
	DeleteUser(tx *sql.Tx, userID string) error
	GetSpecificUser(tx *sql.Tx, userID string) (entities.User, error)
	UserByUsername(tx *sql.Tx, userName string) (entities.User, error)
	LikePost(tx *sql.Tx, userID string, postID uuid.UUID) error
	UnlikePost(tx *sql.Tx, userID string, postID string) error
	FollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	UnfollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	MuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	UnmuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	BlockUser(tx *sql.Tx, sourceUserID, targetUserID string) error
	UnblockUser(tx *sql.Tx, sourceUserID, targetUserID string) error
}
