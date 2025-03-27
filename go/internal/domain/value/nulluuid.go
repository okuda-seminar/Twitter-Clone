package value

import "github.com/google/uuid"

type NullUUID uuid.NullUUID

func (u NullUUID) IsZero() bool {
	return !u.Valid
}

// Scan implements the SQL driver.Scanner interface.
func (nu *NullUUID) Scan(value interface{}) error {
	if value == nil {
		nu.UUID, nu.Valid = uuid.Nil, false
		return nil
	}

	err := nu.UUID.Scan(value)
	if err != nil {
		nu.Valid = false
		return err
	}

	nu.Valid = true
	return nil
}
