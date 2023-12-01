package profileapi

import (
	"context"
	"database/sql"
	"errors"
	"log"
	"profile/db/repository"
	profile "profile/gen/profile"
)

const (
	usernameLenMin = 1
	usernameLenMax = 20

	bioLenMin = 0
	bioLenMax = 160
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
		return nil, profile.MakeNotFound(err)
	}
	res = &profile.User{
		Username: user.Username,
		Bio:      user.Bio,
	}
	s.logger.Print("profile.FindByID")
	return
}

func (s *profileSrvc) UpdateUsername(
	ctx context.Context,
	p *profile.UpdateUsernamePayload,
) (err error) {
	if len(p.Username) < usernameLenMin || len(p.Username) > usernameLenMax {
		return profile.MakeBadRequest(errors.New("username is invalid"))
	}
	if _, err := s.repository.FindByID(ctx, p.ID); err != nil {
		return profile.MakeNotFound(err)
	}

	err = s.repository.UpdateUsername(ctx, p.ID, p.Username)
	s.logger.Print("profile.UpdateUsername")
	return
}

func (s *profileSrvc) UpdateBio(
	ctx context.Context,
	p *profile.UpdateBioPayload,
) (err error) {
	if len(p.Bio) < bioLenMin || len(p.Bio) > bioLenMax {
		return profile.MakeBadRequest(errors.New("bio is invalid"))
	}
	if _, err := s.repository.FindByID(ctx, p.ID); err != nil {
		return profile.MakeNotFound(err)
	}

	err = s.repository.UpdateBio(ctx, p.ID, p.Bio)
	s.logger.Print("profile.UpdateBio")
	return
}
