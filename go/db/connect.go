package db

import (
	"database/sql"
	"os"

	_ "github.com/jackc/pgx/v5/stdlib"
)

func Connect() (*sql.DB, error) {
	pgURL := os.Getenv("PGURL")
	db, err := sql.Open("pgx", pgURL)
	if err != nil {
		return nil, err
	}

	return db, nil
}
