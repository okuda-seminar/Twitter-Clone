package service

import (
	"context"
	"database/sql"
	"errors"
	"log"
	"time"
	"users/db/repository"
	users "users/gen/users"
)

// usersSvc implements users/gen/users.Service.
type usersSvc struct {
	repository repository.UsersRepo
	logger     *log.Logger
}

// NewUsersSvc returns the users service implementation.
func NewUsersSvc(db *sql.DB, logger *log.Logger) users.Service {
	repository := repository.NewUsersRepoImpl(db)
	return &usersSvc{repository, logger}
}

func (s *usersSvc) CreateUser(
	ctx context.Context,
	p *users.CreateUserPayload,
) (res *users.User, err error) {
	if !validateUsername(p.Username) {
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, users.MakeBadRequest(errors.New("username is invalid"))
	}

	user, err := s.repository.CreateUser(ctx, p.Username)
	if err != nil {
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, users.MakeBadRequest(err)
	}

	res = &users.User{
		UserID:    user.UserID,
		Username:  user.Username,
		Bio:       user.Bio,
		CreatedAt: user.CreatedAt.Format(time.RFC3339),
		UpdatedAt: user.UpdatedAt.Format(time.RFC3339),
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
		UserID:    user.UserID,
		Username:  user.Username,
		Bio:       user.Bio,
		CreatedAt: user.CreatedAt.Format(time.RFC3339),
		UpdatedAt: user.UpdatedAt.Format(time.RFC3339),
	}

	s.logger.Print("users.FindByID")
	return
}

func (s *usersSvc) UpdateUsername(
	ctx context.Context,
	p *users.UpdateUsernamePayload,
) (err error) {
	if !validateUsername(p.Username) {
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
	if !validateBio(p.Bio) {
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

const (
	usernameLenMin = 1
	usernameLenMax = 20
)

func validateUsername(username string) bool {
	if len(username) < usernameLenMin || usernameLenMax < len(username) {
		return false
	}
	return true
}

const (
	bioLenMin = 0
	bioLenMax = 160
)

func validateBio(bio string) bool {
	if len(bio) < bioLenMin || bioLenMax < len(bio) {
		return false
	}
	return true
}
