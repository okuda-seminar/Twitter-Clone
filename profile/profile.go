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

func (s *profileSrvc) CreateUser(
	ctx context.Context,
	p *profile.CreateUserPayload,
) (res *profile.User, err error) {
	user, err := s.repository.CreateUser(ctx, p.Username)
	if err != nil {
		s.logger.Printf("profile.CreateUser: failed (%s)", err)
		return nil, profile.MakeBadRequest(err)
	}
	res = &profile.User{
		Username: user.Username,
		Bio:      user.Bio,
	}

	s.logger.Print("profile.CreateUser")
	return
}

func (s *profileSrvc) DeleteUser(
	ctx context.Context,
	p *profile.DeleteUserPayload,
) (err error) {
	err = s.repository.DeleteUser(ctx, p.ID)
	if err != nil {
		s.logger.Printf("profile.DeleteUser: failed (%s)", err)
		return profile.MakeBadRequest(err)
	}

	s.logger.Print("profile.DeleteUser")
	return
}

func (s *profileSrvc) FindByID(
	ctx context.Context,
	p *profile.FindByIDPayload,
) (res *profile.User, err error) {
	user, err := s.repository.FindByID(ctx, p.ID)
	if err != nil {
		s.logger.Printf("profile.FindByID: failed (%s)", err)
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
		s.logger.Printf("profile.UpdateUsername: failed (%s)", err)
		return profile.MakeBadRequest(errors.New("username is invalid"))
	}

	err = s.repository.UpdateUsername(ctx, p.ID, p.Username)
	if err != nil {
		s.logger.Printf("profile.UpdateUsername: failed (%s)", err)
		return profile.MakeBadRequest(err)
	}

	s.logger.Print("profile.UpdateUsername")
	return
}

func (s *profileSrvc) UpdateBio(
	ctx context.Context,
	p *profile.UpdateBioPayload,
) (err error) {
	if len(p.Bio) < bioLenMin || len(p.Bio) > bioLenMax {
		s.logger.Printf("profile.UpdateBio: failed (%s)", err)
		return profile.MakeBadRequest(errors.New("bio is invalid"))
	}

	err = s.repository.UpdateBio(ctx, p.ID, p.Bio)
	if err != nil {
		s.logger.Printf("profile.UpdateBio: failed (%s)", err)
		return profile.MakeBadRequest(err)
	}

	s.logger.Print("profile.UpdateBio")
	return
}
