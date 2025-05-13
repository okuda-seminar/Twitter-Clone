package value

import "github.com/google/uuid"

type NullUUID struct {
	UUID  string
	Valid bool
}

func (u NullUUID) IsZero() bool {
	return !u.Valid
}

// Scan implements the SQL driver.Scanner interface.
func (nu *NullUUID) Scan(value any) error {
	if value == nil {
		nu.UUID, nu.Valid = uuid.Nil.String(), false
		return nil
	}

	var u uuid.UUID
	err := u.Scan(value)
	if err != nil {
		nu.Valid = false
		return err
	}

	nu.UUID, nu.Valid = u.String(), true
	return nil
}
