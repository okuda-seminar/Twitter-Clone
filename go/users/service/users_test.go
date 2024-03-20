package service

import (
	"context"
	"database/sql"
	"log"
	"os"
	"regexp"
	"testing"
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
	rows := sqlmock.NewRows([]string{"id", "username", "bio"}).
		AddRow(user.ID, user.Username, user.Bio)

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

	expected := &repository.User{
		ID:       1,
		Username: "test user",
		Bio:      "some bio",
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

	query := "UPDATE users SET username = $1 where id = $2"
	updatedUsername := "updated"
	dbMock.mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs(updatedUsername, 1).
		WillReturnResult(sqlmock.NewResult(1, 1))

	p := &users.UpdateUsernamePayload{ID: 1, Username: updatedUsername}
	err = service.UpdateUsername(context.Background(), p)
	assert.NoError(t, err)
}

func TestUpdateBio(t *testing.T) {
	service, dbMock, err := setup()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer dbMock.close()

	query := "UPDATE users SET bio = $1 where id = $2"
	updatedBio := "updated"
	dbMock.mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs(updatedBio, 1).
		WillReturnResult(sqlmock.NewResult(1, 1))

	p := &users.UpdateBioPayload{ID: 1, Bio: updatedBio}
	err = service.UpdateBio(context.Background(), p)
	assert.NoError(t, err)
}
