package db

import (
	"database/sql"
)

func ConnectToDB() (*sql.DB, error) {
	// Since the required configurations such as host, name, password, etc., have already been set
	// as environment variables, there is no need to specify them here.
	db, err := sql.Open("pgx", "postgres://")
	if err != nil {
		return nil, err
	}

	return db, nil
}
