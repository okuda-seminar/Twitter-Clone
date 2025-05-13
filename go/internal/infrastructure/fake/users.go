package fake

import (
	"database/sql"
	"slices"
	"sync"
	"time"

	"github.com/google/uuid"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/repository"
)

type fakeUsersRepository struct {
	mu          sync.RWMutex
	users       map[string]entity.User
	likes       map[string][]string // userID to postIDs
	followships map[string][]string // sourceUserID to targetUserIDs
	mutes       map[string][]string // sourceUserID to targetUserIDs
	blocks      map[string][]string // sourceUserID to targetUserIDs

	errors map[string]error
}

func NewFakeUsersRepository() repository.UsersRepository {
	return &fakeUsersRepository{
		mu:          sync.RWMutex{},
		users:       make(map[string]entity.User),
		likes:       make(map[string][]string),
		followships: make(map[string][]string),
		mutes:       make(map[string][]string),
		blocks:      make(map[string][]string),
		errors:      make(map[string]error),
	}
}

func (r *fakeUsersRepository) WithTransaction(fn func(tx *sql.Tx) error) error {
	return nil
}

func (r *fakeUsersRepository) CreateUser(tx *sql.Tx, username, displayName, password string) (entity.User, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["CreateUser"]; ok {
		return entity.User{}, err
	}

	user := entity.User{
		ID:          uuid.NewString(),
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
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["DeleteUser"]; ok {
		return err
	}

	if _, ok := r.users[userID]; !ok {
		return repository.ErrRecordNotFound
	}
	delete(r.users, userID)

	return nil
}

func (r *fakeUsersRepository) UserByUserID(tx *sql.Tx, userID string) (entity.User, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if err, ok := r.errors["UserByUserID"]; ok {
		return entity.User{}, err
	}

	user, ok := r.users[userID]
	if !ok {
		return entity.User{}, repository.ErrRecordNotFound
	}

	return user, nil
}

func (r *fakeUsersRepository) UserByUsername(tx *sql.Tx, username string) (entity.User, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if err, ok := r.errors["UserByUsername"]; ok {
		return entity.User{}, err
	}

	for _, user := range r.users {
		if user.Username == username {
			return user, nil
		}
	}

	return entity.User{}, repository.ErrRecordNotFound
}

func (r *fakeUsersRepository) LikePost(tx *sql.Tx, userID, postID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["LikePost"]; ok {
		return err
	}
	r.likes[userID] = append(r.likes[userID], postID)

	return nil
}

func (r *fakeUsersRepository) UnlikePost(tx *sql.Tx, userID, postID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["UnlikePost"]; ok {
		return err
	}

	likes := r.likes[userID]
	for i, like := range likes {
		if like == postID {
			r.likes[userID] = likes[:i+copy(likes[i:], likes[i+1:])]
			return nil
		}
	}

	return repository.ErrRecordNotFound
}

func (r *fakeUsersRepository) FollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["FollowUser"]; ok {
		return err
	}
	r.followships[sourceUserID] = append(r.followships[sourceUserID], targetUserID)

	return nil
}

func (r *fakeUsersRepository) UnfollowUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["UnfollowUser"]; ok {
		return err
	}

	followships := r.followships[sourceUserID]
	for i, followship := range followships {
		if followship == targetUserID {
			r.followships[sourceUserID] = followships[:i+copy(followships[i:], followships[i+1:])]
			return nil
		}
	}

	return repository.ErrRecordNotFound
}

func (r *fakeUsersRepository) Followees(tx *sql.Tx, targetUserID string) ([]string, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if err, ok := r.errors["Followees"]; ok {
		return nil, err
	}

	var ids []string
	for sourceUserID, followers := range r.followships {
		if slices.Contains(followers, targetUserID) {
			ids = append(ids, sourceUserID)
		}
	}

	return ids, nil
}

func (r *fakeUsersRepository) MuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["MuteUser"]; ok {
		return err
	}
	r.mutes[sourceUserID] = append(r.mutes[sourceUserID], targetUserID)

	return nil
}

func (r *fakeUsersRepository) UnmuteUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["UnmuteUser"]; ok {
		return err
	}

	mutes := r.mutes[sourceUserID]
	for i, mute := range mutes {
		if mute == targetUserID {
			r.mutes[sourceUserID] = mutes[:i+copy(mutes[i:], mutes[i+1:])]
			return nil
		}
	}

	return repository.ErrRecordNotFound
}

func (r *fakeUsersRepository) BlockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["BlockUser"]; ok {
		return err
	}
	r.blocks[sourceUserID] = append(r.blocks[sourceUserID], targetUserID)

	return nil
}

func (r *fakeUsersRepository) UnblockUser(tx *sql.Tx, sourceUserID, targetUserID string) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if err, ok := r.errors["UnblockUser"]; ok {
		return err
	}

	blocks := r.blocks[sourceUserID]
	for i, block := range blocks {
		if block == targetUserID {
			r.blocks[sourceUserID] = blocks[:i+copy(blocks[i:], blocks[i+1:])]
			return nil
		}
	}

	return repository.ErrRecordNotFound
}

func (r *fakeUsersRepository) SetError(key string, err error) {
	r.mu.Lock()
	defer r.mu.Unlock()
	r.errors[key] = err
}

func (r *fakeUsersRepository) ClearError(key string) {
	r.mu.Lock()
	defer r.mu.Unlock()
	delete(r.errors, key)
}
