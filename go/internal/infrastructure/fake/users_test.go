package fake

import (
	"errors"
	"testing"

	"x-clone-backend/internal/domain/repository"

	"github.com/google/uuid"
)

func TestFakeUsersRepository_CreateUser(t *testing.T) {
	fakeUsersRepository := NewFakeUsersRepository()

	username, displayName, password := "test_user", "test user", "password"

	user, err := fakeUsersRepository.CreateUser(nil, username, displayName, password)
	if err != nil {
		t.Errorf("Error creating user: %v", err)
	}

	if user.ID == uuid.Nil {
		t.Errorf("Expected non-nil user ID, got nil")
	}
	if user.Username != username {
		t.Errorf("Expected username %s, got %s", username, user.Username)
	}
	if user.DisplayName != displayName {
		t.Errorf("Expected display name %s, got %s", displayName, user.DisplayName)
	}
	if user.Password != password {
		t.Errorf("Expected password %s, got %s", password, user.Password)
	}
	if user.Bio != "" {
		t.Errorf("Expected empty bio, got %s", user.Bio)
	}
	if user.IsPrivate != false {
		t.Errorf("Expected IsPrivate to be false, got true")
	}

	// Create a user with the same username (unique violation).
	_, err = fakeUsersRepository.CreateUser(nil, "test_user", "test user", "password")
	if err == nil {
		t.Errorf("Expected error, got nil")
	}
	if !errors.Is(err, repository.ErrUniqueViolation) {
		t.Errorf("Expected unique violation error, got %v", err)
	}
}

func TestFakeUsersRepository_CreateUser_WithError(t *testing.T) {
	fakeUsersRepository := NewFakeUsersRepository()

	expectedErr := errors.New("something went wrong")
	fakeUsersRepository.SetCreateUserError(expectedErr)

	_, err := fakeUsersRepository.CreateUser(nil, "test_user", "test user", "password")
	if err != expectedErr {
		t.Errorf("Expected error %v, got %v", expectedErr, err)
	}
}
