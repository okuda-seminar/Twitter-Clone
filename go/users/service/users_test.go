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
	"github.com/stretchr/testify/assert"
)

type DBMock struct {
	db   *sql.DB
	mock sqlmock.Sqlmock
}

func (dbMock *DBMock) close() {
	dbMock.db.Close()
}

func (dbMock *DBMock) insertUser(user *repository.User) {
	rows := sqlmock.NewRows([]string{"id", "username", "account_name", "bio", "created_at", "updated_at"}).
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
	expected := &repository.User{
		ID:          1,
		Username:    "test user",
		DisplayName: "test account",
		Bio:         "some bio",
		CreatedAt:   now,
		UpdatedAt:   now,
	}
	dbMock.insertUser(expected)

	p := &users.FindUserByIDPayload{ID: 1}
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

	query := "UPDATE users SET username = $1 where user_id = $2"

	dbMock.mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs("updated", 1).
		WillReturnResult(sqlmock.NewResult(1, 1))

	tests := []struct {
		payload   users.UpdateUsernamePayload
		expectErr bool
	}{
		{
			payload:   users.UpdateUsernamePayload{ID: 1, Username: "updated"},
			expectErr: false,
		},
		// Too short username.
		{
			payload:   users.UpdateUsernamePayload{ID: 1, Username: ""},
			expectErr: true,
		},
		// Too long username.
		{
			payload:   users.UpdateUsernamePayload{ID: 1, Username: strings.Repeat("a", 21)},
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

	query := "UPDATE users SET bio = $1 where user_id = $2"
	dbMock.mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs("updated", 1).
		WillReturnResult(sqlmock.NewResult(1, 1))

	tests := []struct {
		payload   users.UpdateBioPayload
		expectErr bool
	}{
		{
			payload:   users.UpdateBioPayload{ID: 1, Bio: "updated"},
			expectErr: false,
		},
		// Too long bio.
		{
			payload:   users.UpdateBioPayload{ID: 1, Bio: strings.Repeat("a", 161)},
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
