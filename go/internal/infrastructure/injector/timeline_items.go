package injector

import (
	"database/sql"
	"testing"

	"github.com/redis/go-redis/v9"

	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/cache"
	"x-clone-backend/internal/infrastructure/fake"
	"x-clone-backend/internal/infrastructure/implementation"
	"x-clone-backend/internal/infrastructure/rdb"
)

func InjectTimelineItemsRepository(db *sql.DB, client *redis.Client) repository.TimelineItemsRepository {
	if testing.Testing() {
		return fake.NewFakeTimelineItemsRepository()
	}

	cacheRepo := cache.NewcacheTimelineItemsRepository(client)
	rdbRepo := rdb.NewRDBTimelineItemsRepository(db)

	return implementation.NewTimelineItemsRepository(cacheRepo, rdbRepo)
}
