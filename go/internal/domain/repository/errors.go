package repository

import "errors"

var (
	ErrRecordNotFound  = errors.New("record not found")
	ErrUniqueViolation = errors.New("unique violation")
)
