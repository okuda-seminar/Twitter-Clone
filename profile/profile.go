package profileapi

import (
	"context"
	"database/sql"
	"log"
	"profile/db/repository"
	profile "profile/gen/profile"
)

// profile service implementation.
type profileSrvc struct {
	repository repository.Repository
	logger     *log.Logger
}

// NewProfile returns the profile service implementation.
func NewProfile(db *sql.DB, logger *log.Logger) profile.Service {
	repository := repository.NewRepository(db)
	return &profileSrvc{&repository, logger}
}

// FindByID finds a user with the specified ID.
func (s *profileSrvc) FindByID(
	ctx context.Context,
	p *profile.FindByIDPayload,
) (res *profile.User, err error) {
	user, err := s.repository.FindByID(ctx, p.ID)
	if err != nil {
		return nil, err
	}
	res = &profile.User{
		Username: user.Username,
		Bio:      user.Bio,
	}
	s.logger.Print("profile.FindByID")
	return
}
