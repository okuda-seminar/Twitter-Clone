package usersapi

import (
	"context"
	"database/sql"
	"errors"
	"log"
	"users/db/repository"
	users "users/gen/users"
)

const (
	usernameLenMin = 1
	usernameLenMax = 20

	bioLenMin = 0
	bioLenMax = 160
)

// users service implementation.
type usersSvc struct {
	repository repository.Repository
	logger     *log.Logger
}

// NewUsers returns the users service implementation.
func NewUsersSvc(db *sql.DB, logger *log.Logger) users.Service {
	repository := repository.NewRepository(db)
	return &usersSvc{&repository, logger}
}

func (s *usersSvc) CreateUser(
	ctx context.Context,
	p *users.CreateUserPayload,
) (res *users.User, err error) {
	user, err := s.repository.CreateUser(ctx, p.Username)
	if err != nil {
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, users.MakeBadRequest(err)
	}
	res = &users.User{
		Username: user.Username,
		Bio:      user.Bio,
	}

	s.logger.Print("users.CreateUser")
	return
}

func (s *usersSvc) DeleteUser(
	ctx context.Context,
	p *users.DeleteUserPayload,
) (err error) {
	err = s.repository.DeleteUser(ctx, p.ID)
	if err != nil {
		// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/15
		// - Discuss logging structure.
		s.logger.Printf("users.DeleteUser: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.DeleteUser")
	return
}

func (s *usersSvc) FindUserByID(
	ctx context.Context,
	p *users.FindUserByIDPayload,
) (res *users.User, err error) {
	user, err := s.repository.FindUserByID(ctx, p.ID)
	if err != nil {
		s.logger.Printf("users.FindByID: failed (%s)", err)
		return nil, users.MakeNotFound(err)
	}
	res = &users.User{
		Username: user.Username,
		Bio:      user.Bio,
	}

	s.logger.Print("users.FindByID")
	return
}

func (s *usersSvc) UpdateUsername(
	ctx context.Context,
	p *users.UpdateUsernamePayload,
) (err error) {
	if len(p.Username) < usernameLenMin || len(p.Username) > usernameLenMax {
		s.logger.Printf("users.UpdateUsername: failed (%s)", err)
		return users.MakeBadRequest(errors.New("username is invalid"))
	}

	err = s.repository.UpdateUsername(ctx, p.ID, p.Username)
	if err != nil {
		s.logger.Printf("users.UpdateUsername: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.UpdateUsername")
	return
}

func (s *usersSvc) UpdateBio(
	ctx context.Context,
	p *users.UpdateBioPayload,
) (err error) {
	if len(p.Bio) < bioLenMin || len(p.Bio) > bioLenMax {
		s.logger.Printf("users.UpdateBio: failed (%s)", err)
		return users.MakeBadRequest(errors.New("bio is invalid"))
	}

	err = s.repository.UpdateBio(ctx, p.ID, p.Bio)
	if err != nil {
		s.logger.Printf("users.UpdateBio: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.UpdateBio")
	return
}
