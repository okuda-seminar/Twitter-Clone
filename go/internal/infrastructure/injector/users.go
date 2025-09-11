package injector

import (
	"database/sql"
	"testing"

	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/infrastructure/fake"
	"x-clone-backend/internal/infrastructure/rdb"
)

func InjectUsersRepository(db *sql.DB) repository.UsersRepository {
	if testing.Testing() {
		return fake.NewFakeUsersRepository()
	}
	return rdb.NewUsersRepository(db)
}
