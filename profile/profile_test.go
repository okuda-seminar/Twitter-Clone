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

	logger := log.New(os.Stderr, "[profileapi] ", log.Ltime)
	service := NewProfile(db, logger)
	return service, db, mock, nil
}

func TestFindByID(t *testing.T) {
	service, db, mock, err := NewDBMock()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer db.Close()

	testUser := &repository.User{
		ID:       1,
		Username: "test user",
		Bio:      "some bio",
	}

	query := "SELECT * FROM users WHERE id = $1"
	rows := sqlmock.NewRows([]string{"id", "username", "bio"}).
		AddRow(testUser.ID, testUser.Username, testUser.Bio)

	mock.ExpectQuery(regexp.QuoteMeta(query)).
		WithArgs(testUser.ID).
		WillReturnRows(rows)

	p := &profile.FindByIDPayload{ID: testUser.ID}
	user, err := service.FindByID(context.Background(), p)
	assert.NotNil(t, user)
	assert.NoError(t, err)
}
