package service

import (
	"context"
	"database/sql"
	"log"
	"os"
	"regexp"
	"strings"
	"testing"
	"time"
	"users/db/repository"
	"users/gen/users"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"
)

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/145
// - Improve test flow.
type DBMock struct {
	db   *sql.DB
	mock sqlmock.Sqlmock
}

func (dbMock *DBMock) close() {
	dbMock.db.Close()
}

func (dbMock *DBMock) insertUser(user *repository.User) {
	rows := sqlmock.NewRows([]string{"id", "username", "display_name", "bio", "created_at", "updated_at"}).
		AddRow(user.ID, user.Username, user.DisplayName, user.Bio, user.CreatedAt, user.UpdatedAt)

	query := "SELECT * FROM users WHERE id = $1"
	dbMock.mock.ExpectQuery(regexp.QuoteMeta(query)).
		WithArgs(user.ID).
		WillReturnRows(rows)
}

func setup() (users.Service, *DBMock, error) {
	db, mock, err := sqlmock.New()
	if err != nil {
		return nil, nil, err
	}
	dbMock := &DBMock{
		db:   db,
		mock: mock,
	}

	logger := log.New(os.Stderr, "[usersapiTest] ", log.Ltime)
	service := NewUsersSvc(db, logger)

	return service, dbMock, nil
}

func TestFindUserByID(t *testing.T) {
	service, dbMock, err := setup()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer dbMock.close()

	now := time.Now()
	id := uuid.New()
	expected := &repository.User{
		ID:          id,
		Username:    "test user",
		DisplayName: "test account",
		Bio:         "some bio",
		CreatedAt:   now,
		UpdatedAt:   now,
	}
	dbMock.insertUser(expected)

	p := &users.FindUserByIDPayload{ID: id.String()}
	actual, err := service.FindUserByID(context.Background(), p)
	assert.NoError(t, err)
	assert.Equal(t, actual.Username, expected.Username)
	assert.Equal(t, actual.Bio, expected.Bio)
}

func TestUpdateUsername(t *testing.T) {
	service, dbMock, err := setup()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer dbMock.close()

	query := "UPDATE users SET username = $1 where id = $2"
	id := uuid.NewString()
	dbMock.mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs("updated", id).
		WillReturnResult(sqlmock.NewResult(1, 1))

	tests := []struct {
		payload   users.UpdateUsernamePayload
		expectErr bool
	}{
		{
			payload:   users.UpdateUsernamePayload{ID: id, Username: "updated"},
			expectErr: false,
		},
		// Too short username.
		{
			payload:   users.UpdateUsernamePayload{ID: id, Username: ""},
			expectErr: true,
		},
		// Too long username.
		{
			payload:   users.UpdateUsernamePayload{ID: id, Username: strings.Repeat("a", 21)},
			expectErr: true,
		},
	}

	for _, tt := range tests {
		err := service.UpdateUsername(context.Background(), &tt.payload)
		if tt.expectErr {
			if err == nil {
				t.Errorf("expected err, but got nil")
			}
		} else {
			if err != nil {
				t.Errorf("expected nil, but got err: %v", err)
			}
		}
	}
}

func TestUpdateBio(t *testing.T) {
	service, dbMock, err := setup()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer dbMock.close()

	query := "UPDATE users SET bio = $1 where id = $2"
	id := uuid.NewString()
	dbMock.mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs("updated", id).
		WillReturnResult(sqlmock.NewResult(1, 1))

	tests := []struct {
		payload   users.UpdateBioPayload
		expectErr bool
	}{
		{
			payload:   users.UpdateBioPayload{ID: id, Bio: "updated"},
			expectErr: false,
		},
		// Too long bio.
		{
			payload:   users.UpdateBioPayload{ID: id, Bio: strings.Repeat("a", 161)},
			expectErr: true,
		},
	}

	for _, tt := range tests {
		err := service.UpdateBio(context.Background(), &tt.payload)
		if tt.expectErr {
			if err == nil {
				t.Errorf("expected err, but got nil")
			}
		} else {
			if err != nil {
				t.Errorf("expected nil, but got err: %v", err)
			}
		}
	}
}

func TestGetFollowers(t *testing.T) {
	service, dbMock, err := setup()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer dbMock.close()

	id := uuid.NewString()
	rows := sqlmock.NewRows([]string{
		"id", "username", "display_name", "bio", "created_at", "updated_at",
		"follower_id", "followee_id",
	}).
		AddRow(uuid.NewString(), "second", "second", "", time.Now(), time.Now(), uuid.NewString(), id).
		AddRow(uuid.NewString(), "third", "third", "", time.Now(), time.Now(), uuid.NewString(), id)

	query := `
SELECT * FROM users
JOIN followships ON users.id = followships.follower_id
WHERE followships.followee_id = $1
`
	dbMock.mock.ExpectQuery(regexp.QuoteMeta(query)).
		WithArgs(id).
		WillReturnRows(rows)

	p := &users.GetFollowersPayload{ID: id}
	followers, err := service.GetFollowers(context.Background(), p)
	if err != nil {
		t.Errorf("cannot get followers: %s", err)
	}

	if len(followers) != 2 {
		t.Errorf("the number of followers was %d, not 2", len(followers))
	}
}

func TestGetFollowings(t *testing.T) {
	service, dbMock, err := setup()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer dbMock.close()

	id := uuid.NewString()
	rows := sqlmock.NewRows([]string{
		"id", "username", "display_name", "bio", "created_at", "updated_at",
		"follower_id", "followee_id",
	}).
		// User with ID "1" follows user with ID "2".
		AddRow(uuid.NewString(), "second", "second", "", time.Now(), time.Now(), id, uuid.NewString()).
		// User with ID "1" follows user with ID "3".
		AddRow(uuid.NewString(), "third", "third", "", time.Now(), time.Now(), id, uuid.NewString())

	query := `
SELECT * FROM users
JOIN followships ON users.id = followships.followee_id
WHERE followships.follower_id = $1
`
	dbMock.mock.ExpectQuery(regexp.QuoteMeta(query)).
		WithArgs(id).
		WillReturnRows(rows)

	p := &users.GetFollowingsPayload{ID: id}
	followers, err := service.GetFollowings(context.Background(), p)
	if err != nil {
		t.Errorf("cannot get followings: %s", err)
	}

	if len(followers) != 2 {
		t.Errorf("the number of followings was %d, not 2", len(followers))
	}
}
