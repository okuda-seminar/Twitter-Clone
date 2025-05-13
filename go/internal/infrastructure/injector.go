package infrastructure

import (
	"database/sql"
	"testing"

	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/fake"
	"x-clone-backend/internal/infrastructure/persistence"
)

func InjectUsersRepository(db *sql.DB) repository.UsersRepository {
	if testing.Testing() {
		return fake.NewFakeUsersRepository()
	}
	return persistence.NewUsersRepository(db)
}

func InjectTimelineItemsRepository(db *sql.DB) repository.TimelineItemsRepository {
	if testing.Testing() {
		return fake.NewFakeTimelineItemsRepository()
	}
	return persistence.NewTimelineitemsRepository(db)
}
