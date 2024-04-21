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
	usersRepo       repository.UsersRepo
	followshipsRepo repository.FollowshipsRepo
	logger          *log.Logger
}

// NewUsersSvc returns the users service implementation.
func NewUsersSvc(db *sql.DB, logger *log.Logger) users.Service {
	usersRepo := repository.NewUsersRepoImpl(db)
	followshipsRepo := repository.NewFollowshipsRepoImpl(db)
	return &usersSvc{usersRepo, followshipsRepo, logger}
}

func (s *usersSvc) CreateUser(
	ctx context.Context,
	p *users.CreateUserPayload,
) (res *users.User, err error) {
	if !validateUsername(p.Username) {
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, users.MakeBadRequest(errors.New("username is invalid"))
	}

	user, err := s.usersRepo.CreateUser(ctx, p.Username, p.DisplayName)
	if err != nil {
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, users.MakeBadRequest(err)
	}

	res = &users.User{
		ID:          user.ID,
		Username:    user.Username,
		DisplayName: user.DisplayName,
		Bio:         user.Bio,
		CreatedAt:   user.CreatedAt.Format(time.RFC3339),
		UpdatedAt:   user.UpdatedAt.Format(time.RFC3339),
	}

	s.logger.Print("users.CreateUser")
	return
}

func (s *usersSvc) DeleteUser(
	ctx context.Context,
	p *users.DeleteUserPayload,
) (err error) {
	err = s.usersRepo.DeleteUser(ctx, p.ID)
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
	user, err := s.usersRepo.FindUserByID(ctx, p.ID)
	if err != nil {
		s.logger.Printf("users.FindByID: failed (%s)", err)
		return nil, users.MakeNotFound(err)
	}
	res = &users.User{
		ID:          user.ID,
		Username:    user.Username,
		DisplayName: user.DisplayName,
		Bio:         user.Bio,
		CreatedAt:   user.CreatedAt.Format(time.RFC3339),
		UpdatedAt:   user.UpdatedAt.Format(time.RFC3339),
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

	err = s.usersRepo.UpdateUsername(ctx, p.ID, p.Username)
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

	err = s.usersRepo.UpdateBio(ctx, p.ID, p.Bio)
	if err != nil {
		s.logger.Printf("users.UpdateBio: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.UpdateBio")
	return
}

func (s *usersSvc) Follow(
	ctx context.Context,
	p *users.FollowPayload,
) error {
	err := s.followshipsRepo.CreateFollowship(ctx, p.FollowerID, p.FolloweeID)
	if err != nil {
		s.logger.Printf("users.Follow: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Follow")
	return nil
}

func (s *usersSvc) Unfollow(
	ctx context.Context,
	p *users.UnfollowPayload,
) error {
	err := s.followshipsRepo.DeleteFollowship(ctx, p.FollowerID, p.FolloweeID)
	if err != nil {
		s.logger.Printf("users.Unfollow: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Unfollow")
	return nil
}

const (
	usernameLenMin = 4
	usernameLenMax = 14

	bioLenMin = 0
	bioLenMax = 160
)

func validateUsername(username string) bool {
	if len(username) < usernameLenMin || usernameLenMax < len(username) {
		return false
	}
	return true
}

func validateBio(bio string) bool {
	if len(bio) < bioLenMin || bioLenMax < len(bio) {
		return false
	}
	return true
}
