package service

import (
	"context"
	"database/sql"
	"errors"
	"log"
	"time"
	"users/db/repository"
	users "users/gen/users"

	"github.com/google/uuid"
)

// usersSvc implements users/gen/users.Service.
type usersSvc struct {
	usersRepo       repository.UsersRepo
	followshipsRepo repository.FollowshipsRepo
	mutesRepo       repository.MutesRepo
	blocksRepo      repository.BlocksRepo
	logger          *log.Logger
}

// NewUsersSvc returns the users service implementation.
func NewUsersSvc(db *sql.DB, logger *log.Logger) users.Service {
	usersRepo := repository.NewUsersRepoImpl(db)
	followshipsRepo := repository.NewFollowshipsRepoImpl(db)
	mutesRepo := repository.NewMutesRepoImpl(db)
	blocksRepo := repository.NewBlocksRepoImpl(db)
	return &usersSvc{usersRepo, followshipsRepo, mutesRepo, blocksRepo, logger}
}

func (s *usersSvc) CreateUser(ctx context.Context, p *users.CreateUserPayload) (*users.User, error) {
	if !validateUsername(p.Username) {
		err := users.MakeBadRequest(errors.New("username is invalid"))
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, err
	}

	user, err := s.usersRepo.CreateUser(ctx, p.Username, p.DisplayName, false)
	if err != nil {
		s.logger.Printf("users.CreateUser: failed (%s)", err)
		return nil, users.MakeBadRequest(err)
	}

	res := mapRepoUserToSvcUser(user)

	s.logger.Print("users.CreateUser")
	return res, nil
}

func (s *usersSvc) DeleteUser(ctx context.Context, p *users.DeleteUserPayload) error {
	userID, _ := uuid.Parse(p.ID)
	err := s.usersRepo.DeleteUser(ctx, userID)
	if err != nil {
		// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/15
		// - Discuss logging structure.
		s.logger.Printf("users.DeleteUser: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.DeleteUser")
	return nil
}

func (s *usersSvc) FindUserByID(ctx context.Context, p *users.FindUserByIDPayload) (*users.User, error) {
	userID, _ := uuid.Parse(p.ID)
	user, err := s.usersRepo.FindUserByID(ctx, userID)
	if err != nil {
		s.logger.Printf("users.FindByID: failed (%s)", err)
		return nil, users.MakeNotFound(err)
	}

	res := mapRepoUserToSvcUser(user)

	s.logger.Print("users.FindByID")
	return res, nil
}

func (s *usersSvc) UpdateProfile(ctx context.Context, p *users.UpdateProfilePayload) error {
	// key is a database field name, and value is the new data, e.g. {"username": "new username"}.
	// Ideally, the service layer should not be aware of database column names,
	// but we will go with this implementation for now.
	var fields = make(map[string]any)

	if p.Username != nil {
		if !validateUsername(*p.Username) {
			err := users.MakeBadRequest(errors.New("username is invalid"))
			s.logger.Printf("users.UpdateProfile: failed (%s)", err)
			return err
		}
		fields["username"] = p.Username
	}

	if p.Bio != nil {
		if !validateBio(*p.Bio) {
			err := users.MakeBadRequest(errors.New("bio is invalid"))
			s.logger.Printf("users.UpdateProfile: failed (%s)", err)
			return err
		}
		fields["bio"] = p.Bio
	}

	if p.IsPrivate != nil {
		fields["is_private"] = p.IsPrivate
	}

	id, _ := uuid.Parse(p.ID)

	err := s.usersRepo.UpdateProfile(ctx, id, fields)
	if err != nil {
		s.logger.Printf("users.UpdateProfile: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.UpdateProfile")
	return nil
}

func (s *usersSvc) Follow(ctx context.Context, p *users.FollowPayload) error {
	followed_user_id, _ := uuid.Parse(p.FollowedUserID)
	following_user_id, _ := uuid.Parse(p.FollowingUserID)
	if following_user_id == followed_user_id {
		err := users.MakeBadRequest(errors.New("user tries to follow self"))
		s.logger.Printf("users.Follow: failed (%s)", err)
		return err
	}
	err := s.followshipsRepo.CreateFollowship(ctx, followed_user_id, following_user_id)
	if err != nil {
		s.logger.Printf("users.Follow: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Follow")
	return nil
}

func (s *usersSvc) Unfollow(ctx context.Context, p *users.UnfollowPayload) error {
	followed_user_id, _ := uuid.Parse(p.FollowedUserID)
	following_user_id, _ := uuid.Parse(p.FollowingUserID)
	if following_user_id == followed_user_id {
		err := users.MakeBadRequest(errors.New("user tries to unfollow self"))
		s.logger.Printf("users.Unfollow: failed (%s)", err)
		return err
	}
	err := s.followshipsRepo.DeleteFollowship(ctx, followed_user_id, following_user_id)
	if err != nil {
		// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/345
		// - Add an error to the Unfollow function when trying to unfollow a non-existent user
		s.logger.Printf("users.Unfollow: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Unfollow")
	return nil
}

func (s *usersSvc) GetFollowers(ctx context.Context, p *users.GetFollowersPayload) ([]*users.User, error) {
	var res []*users.User

	userID, _ := uuid.Parse(p.ID)
	followers, err := s.usersRepo.GetFollowers(ctx, userID)
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

func (s *usersSvc) GetFollowings(ctx context.Context, p *users.GetFollowingsPayload) ([]*users.User, error) {
	var res []*users.User

	userID, _ := uuid.Parse(p.ID)
	followings, err := s.usersRepo.GetFollowings(ctx, userID)
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
	muted_user_id, _ := uuid.Parse(p.MutedUserID)
	muting_user_id, _ := uuid.Parse(p.MutingUserID)
	err := s.mutesRepo.CreateMute(ctx, muted_user_id, muting_user_id)
	if err != nil {
		s.logger.Printf("users.Mute: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Mute")
	return nil
}

func (s *usersSvc) Unmute(ctx context.Context, p *users.UnmutePayload) error {
	muted_user_id, _ := uuid.Parse(p.MutedUserID)
	muting_user_id, _ := uuid.Parse(p.MutingUserID)
	err := s.mutesRepo.DeleteMute(ctx, muted_user_id, muting_user_id)
	if err != nil {
		s.logger.Printf("users.Unmute: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Unmute")
	return nil
}

func (s *usersSvc) Block(ctx context.Context, p *users.BlockPayload) error {
	blocked_user_id, _ := uuid.Parse(p.BlockedUserID)
	blocking_user_id, _ := uuid.Parse(p.BlockingUserID)
	err := s.followshipsRepo.DeleteFollowship(ctx, blocked_user_id, blocking_user_id)
	if err != nil {
		s.logger.Printf("users.Block: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	err = s.followshipsRepo.DeleteFollowship(ctx, blocked_user_id, blocking_user_id)
	if err != nil {
		s.logger.Printf("users.Block: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	err = s.mutesRepo.DeleteMute(ctx, blocked_user_id, blocking_user_id)
	if err != nil {
		s.logger.Printf("users.Block: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	err = s.blocksRepo.CreateBlock(ctx, blocked_user_id, blocking_user_id)
	if err != nil {
		s.logger.Printf("users.Block: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Block")
	return nil
}

func (s *usersSvc) Unblock(ctx context.Context, p *users.UnblockPayload) error {
	blocked_user_id, _ := uuid.Parse(p.BlockedUserID)
	blocking_user_id, _ := uuid.Parse(p.BlockingUserID)
	err := s.blocksRepo.DeleteBlock(ctx, blocked_user_id, blocking_user_id)
	if err != nil {
		s.logger.Printf("users.Unblock: failed (%s)", err)
		return users.MakeBadRequest(err)
	}

	s.logger.Print("users.Unblock")
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
		IsPrivate:   user.IsPrivate,
	}
}
