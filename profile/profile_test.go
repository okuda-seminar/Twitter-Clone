package profileapi

import (
	"context"
	"database/sql"
	"log"
	"os"
	"profile/db/repository"
	"profile/gen/profile"
	"regexp"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/assert"
)

func NewDBMock() (profile.Service, *sql.DB, sqlmock.Sqlmock, error) {
	db, mock, err := sqlmock.New()
	if err != nil {
		return nil, nil, nil, err
	}

	// insert dummy data.
	testUser := &repository.User{
		ID:       1,
		Username: "test user",
		Bio:      "some bio",
	}

	rows := sqlmock.NewRows([]string{"id", "username", "bio"}).
		AddRow(testUser.ID, testUser.Username, testUser.Bio)

	query := "SELECT * FROM users WHERE id = $1"
	mock.ExpectQuery(regexp.QuoteMeta(query)).
		WithArgs(testUser.ID).
		WillReturnRows(rows)

	// mock up service.
	logger := log.New(os.Stderr, "[profileapi] ", log.Ltime)
	service := NewProfile(db, logger)

	return service, db, mock, nil
}

func TestFindByID(t *testing.T) {
	service, db, _, err := NewDBMock()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer db.Close()

	p := &profile.FindByIDPayload{ID: 1}
	user, err := service.FindByID(context.Background(), p)
	assert.NotNil(t, user)
	assert.NoError(t, err)
}

func TestUpdateUsername(t *testing.T) {
	service, db, mock, err := NewDBMock()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer db.Close()

	query := "UPDATE users SET username = $1 where id = $2"
	updatedUsername := "updated"
	mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs(updatedUsername, 1).
		WillReturnResult(sqlmock.NewResult(1, 1))

	p := &profile.UpdateUsernamePayload{ID: 1, Username: updatedUsername}
	err = service.UpdateUsername(context.Background(), p)
	assert.NoError(t, err)
}

func TestUpdateBio(t *testing.T) {
	service, db, mock, err := NewDBMock()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer db.Close()

	query := "UPDATE users SET bio = $1 where id = $2"
	updatedBio := "updated"
	mock.ExpectExec(regexp.QuoteMeta(query)).
		WithArgs(updatedBio, 1).
		WillReturnResult(sqlmock.NewResult(1, 1))

	p := &profile.UpdateBioPayload{ID: 1, Bio: updatedBio}
	err = service.UpdateBio(context.Background(), p)
	assert.NoError(t, err)
}
