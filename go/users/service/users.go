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
	mutesRepo       repository.MutesRepo
	logger          *log.Logger
}

// NewUsersSvc returns the users service implementation.
func NewUsersSvc(db *sql.DB, logger *log.Logger) users.Service {
	usersRepo := repository.NewUsersRepoImpl(db)
	followshipsRepo := repository.NewFollowshipsRepoImpl(db)
	mutesRepo := repository.NewMutesRepoImpl(db)
	return &usersSvc{usersRepo, followshipsRepo, mutesRepo, logger}
}

func (s *usersSvc) CreateUser(
	ctx context.Context,
	p *users.CreateUserPayload,
) (res *users.User, err error) {
	if !validateUsername(p.Username) {
		err = users.MakeBadRequest(errors.New("username is invalid"))
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, err
	}

	user, err := s.usersRepo.CreateUser(ctx, p.Username, p.DisplayName)
	if err != nil {
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, users.MakeBadRequest(err)
	}

	res = mapRepoUserToSvcUser(user)

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
	res = mapRepoUserToSvcUser(user)

	s.logger.Print("users.FindByID")
	return
}

func (s *usersSvc) UpdateUsername(
	ctx context.Context,
	p *users.UpdateUsernamePayload,
) (err error) {
	if !validateUsername(p.Username) {
		err = users.MakeBadRequest(errors.New("username is invalid"))
		s.logger.Printf("users.UpdateUsername: failed (%s)", err)
		return err
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
		err = users.MakeBadRequest(errors.New("bio is invalid"))
		s.logger.Printf("users.UpdateBio: failed (%s)", err)
		return err
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

func (s *usersSvc) GetFollowers(
	ctx context.Context,
	p *users.GetFollowersPayload,
) ([]*users.User, error) {
	var res []*users.User

	followers, err := s.usersRepo.GetFollowers(ctx, p.ID)
	if err != nil {
		return nil, users.MakeBadRequest(err)
	}

	for _, follower := range followers {
		user := mapRepoUserToSvcUser(follower)
		res = append(res, user)
	}

	s.logger.Print("users.GetFollowers")
	return res, nil
}

func (s *usersSvc) GetFollowings(
	ctx context.Context,
	p *users.GetFollowingsPayload,
) ([]*users.User, error) {
	var res []*users.User

	followings, err := s.usersRepo.GetFollowings(ctx, p.ID)
	if err != nil {
		return nil, users.MakeBadRequest(err)
	}

	for _, following := range followings {
		user := mapRepoUserToSvcUser(following)
		res = append(res, user)
	}

	s.logger.Print("users.GetFollowings")
	return res, nil
}

func (s *usersSvc) Mute(ctx context.Context, p *users.MutePayload) error {
	err := s.mutesRepo.CreateMute(ctx, p.MutedUserID, p.MutingUserID)
	if err != nil {
		s.logger.Printf("users.Mute: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Mute")
	return nil
}

func (s *usersSvc) Unmute(ctx context.Context, p *users.UnmutePayload) error {
	err := s.mutesRepo.DeleteMute(ctx, p.MutedUserID, p.MutingUserID)
	if err != nil {
		s.logger.Printf("users.Unmute: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Unmute")
	return nil
}

func (s *usersSvc) Block(ctx context.Context, p *users.BlockPayload) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/223
	// - Implement Block and Unblock API logic.
	return nil
}

func (s *usersSvc) Unblock(ctx context.Context, p *users.UnblockPayload) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/223
	// - Implement Block and Unblock API logic.
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

func mapRepoUserToSvcUser(user *repository.User) *users.User {
	return &users.User{
		ID:          user.ID.String(),
		Username:    user.Username,
		DisplayName: user.DisplayName,
		Bio:         user.Bio,
		CreatedAt:   user.CreatedAt.Format(time.RFC3339),
		UpdatedAt:   user.UpdatedAt.Format(time.RFC3339),
	}
}
