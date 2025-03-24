package fake

import (
	"database/sql"
	"sync"
	"time"

	"github.com/google/uuid"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type fakeUsersRepository struct {
	mu              sync.RWMutex
	users           map[uuid.UUID]entity.User
	createUserError error
}

func NewFakeUsersRepository() repository.UsersRepository {
	return &fakeUsersRepository{
		mu:              sync.RWMutex{},
		users:           make(map[uuid.UUID]entity.User),
		createUserError: nil,
	}
}

// SetCreateUserError sets the error that will be returned by CreateUser.
func (r *fakeUsersRepository) SetCreateUserError(err error) {
	r.mu.Lock()
	defer r.mu.Unlock()
	r.createUserError = err
}

func (r *fakeUsersRepository) WithTransaction(fn func(tx *sql.Tx) error) error {
	return nil
}

func (r *fakeUsersRepository) CreateUser(tx *sql.Tx, username, displayName, password string) (entity.User, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	if r.createUserError != nil {
		return entity.User{}, r.createUserError
	}

	user := entity.User{
		ID:          uuid.New(),
		Username:    username,
		DisplayName: displayName,
		Password:    password,
		Bio:         "",
		IsPrivate:   false,
		CreatedAt:   time.Now(),
		UpdatedAt:   time.Now(),
	}

	for _, u := range r.users {
		if u.Username == user.Username {
			return entity.User{}, repository.ErrUniqueViolation
		}
	}
	r.users[user.ID] = user

	return user, nil
}

func (r *fakeUsersRepository) DeleteUser(tx *sql.Tx, userID string) error {
	return nil
}

func (r *fakeUsersRepository) GetSpecificUser(tx *sql.Tx, userID string) (entity.User, error) {
	return entity.User{}, nil
}

func (r *fakeUsersRepository) GetUserByUsername(tx *sql.Tx, username string) (entity.User, error) {
	return entity.User{}, nil
}

func (r *fakeUsersRepository) UserByUsername(tx *sql.Tx, username string) (entity.User, error) {
	return entity.User{}, nil
}

func (r *fakeUsersRepository) LikePost(tx *sql.Tx, userID string, postID uuid.UUID) error {
	return nil
}

func (r *fakeUsersRepository) UnlikePost(tx *sql.Tx, userID string, postID string) error {
	return nil
}

func (r *fakeUsersRepository) FollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	return nil
}

func (r *fakeUsersRepository) UnfollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	return nil
}

func (r *fakeUsersRepository) MuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	return nil
}

func (r *fakeUsersRepository) UnmuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	return nil
}

func (r *fakeUsersRepository) BlockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	return nil
}

func (r *fakeUsersRepository) UnblockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	return nil
}
