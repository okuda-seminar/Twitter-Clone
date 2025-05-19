package injector

import (
	"database/sql"
	"testing"

	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/fake"
	"x-clone-backend/internal/infrastructure/implementation"
)

func InjectTimelineItemsRepository(db *sql.DB) repository.TimelineItemsRepository {
	if testing.Testing() {
		return fake.NewFakeTimelineItemsRepository()
	}
	return implementation.NewTimelineItemsRepository(db)
}
