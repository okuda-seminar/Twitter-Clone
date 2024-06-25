package service

import (
	"context"
	"strings"
	"testing"
	"users/gen/users"

	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/suite"
)

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/298
// - Add tests for use cases which tests have not yet been implemented for
func (s *UsersTestSuite) TestCreateUser() {
	tests := []struct {
		name         string
		username     string
		display_name string
		expectErr    bool
	}{
		{
			name:         "create user",
			username:     "test_user",
			display_name: "Test User",
			expectErr:    false,
		},
		{
			name:         "duplicated username",
			username:     "test_user",
			display_name: "Another Test User",
			expectErr:    true,
		},
		{
			name:         "too short username",
			username:     "a",
			display_name: "Test User",
			expectErr:    true,
		},
		{
			name:         "too long username",
			username:     strings.Repeat("a", 15),
			display_name: "Test User",
			expectErr:    true,
		},
	}

	for _, test := range tests {
		p := users.CreateUserPayload{Username: test.username, DisplayName: test.display_name}
		user, err := s.service.CreateUser(context.Background(), &p)
		if test.expectErr {
			if err == nil {
				s.T().Errorf("%s: expected err, but got nil", test.name)
			}
		} else {
			if err != nil {
				s.T().Fatalf("%s: expected non-error, but got %s", test.name, err)
			}

			if user.Username != test.username {
				s.T().Errorf("%s (Username): expected %s, but got %s", test.name, test.username, user.Username)
			}
			if user.DisplayName != test.display_name {
				s.T().Errorf("%s (DisplayName): expected %s, but got %s",
					test.name, test.display_name, user.DisplayName)
			}
			if user.Bio != "" {
				s.T().Errorf("%s (Bio): expected empty string, but got %s", test.name, user.Bio)
			}
			if user.IsPrivate != false {
				s.T().Errorf("%s (IsPrivate): expected false, but got %t", test.name, user.IsPrivate)
			}
		}
	}
}

func (s *UsersTestSuite) TestDeleteUser() {
	user := s.create_user("test_user", "Test User")

	tests := []struct {
		name      string
		user_id   string
		expectErr bool
	}{
		{
			name:      "delete user",
			user_id:   user.ID,
			expectErr: false,
		},
		{
			name:      "non-existent user",
			user_id:   user.ID,
			expectErr: true,
		},
	}

	for _, test := range tests {
		p := users.DeleteUserPayload{ID: test.user_id}
		err := s.service.DeleteUser(context.Background(), &p)
		if test.expectErr && err == nil {
			s.T().Errorf("%s: expected err, but got nil", test.name)
		}
		if !test.expectErr && err != nil {
			s.T().Errorf("%s: expected non-error, but got %s", test.name, err)
		}
	}
}

func (s *UsersTestSuite) TestFindUserByID() {
	user := s.create_user("test_user", "Test User")

	tests := []struct {
		name      string
		user_id   string
		expectErr bool
	}{
		{
			name:      "find user",
			user_id:   user.ID,
			expectErr: false,
		},
		{
			name:      "non-existent user",
			user_id:   uuid.NewString(),
			expectErr: true,
		},
	}

	for _, test := range tests {
		p := users.FindUserByIDPayload{ID: test.user_id}
		res, err := s.service.FindUserByID(context.Background(), &p)
		if test.expectErr {
			if err == nil {
				s.T().Errorf("%s: expected err, but got nil", test.name)
			}
		} else {
			if err != nil {
				s.T().Fatalf("%s: expected non-error, but got %s", test.name, err)
			}

			if *res != *user {
				s.T().Errorf("%s: expected %v+, but got %v+", test.name, user, res)
			}
		}
	}
}

func (s *UsersTestSuite) TestUpdateProfile() {
	user := s.create_user("test_user", "Test User")

	username := "updated"
	bio := "updated"
	isPrivate := true

	tests := []struct {
		name      string
		payload   users.UpdateProfilePayload
		expectErr bool
	}{
		{
			name: "update username",
			payload: users.UpdateProfilePayload{
				ID:       user.ID,
				Username: &username,
			},
			expectErr: false,
		},
		{
			name: "update bio",
			payload: users.UpdateProfilePayload{
				ID:  user.ID,
				Bio: &bio,
			},
			expectErr: false,
		},
		{
			name: "update isPrivate",
			payload: users.UpdateProfilePayload{
				ID:        user.ID,
				IsPrivate: &isPrivate,
			},
			expectErr: false,
		},
		{
			name: "update multiple fields",
			payload: users.UpdateProfilePayload{
				ID:       user.ID,
				Username: &username,
				Bio:      &bio,
			},
			expectErr: false,
		},
		{
			name: "non-existent user",
			payload: users.UpdateProfilePayload{
				ID:       uuid.NewString(),
				Username: &username,
			},
			expectErr: true,
		},
	}

	for _, test := range tests {
		err := s.service.UpdateProfile(context.Background(), &test.payload)
		if test.expectErr && err == nil {
			s.T().Errorf("%s: expected err, but got nil", test.name)
		}
		if !test.expectErr && err != nil {
			s.T().Errorf("%s: expected non-error, but got %s", test.name, err)
		}
	}
}

func (s *UsersTestSuite) TestFollow() {
	followed_user := s.create_user("followed_user", "Followed User")
	following_user := s.create_user("following_user", "Following User")

	tests := []struct {
		name              string
		following_user_id string
		followed_user_id  string
		expectErr         bool
	}{
		{
			name:              "follow user",
			following_user_id: following_user.ID,
			followed_user_id:  followed_user.ID,
			expectErr:         false,
		},
		{
			name:              "already followed",
			following_user_id: following_user.ID,
			followed_user_id:  followed_user.ID,
			expectErr:         true,
		},
		{
			name:              "followed user does not exist",
			following_user_id: following_user.ID,
			followed_user_id:  uuid.NewString(),
			expectErr:         true,
		},
		{
			name:              "following user does not exist",
			following_user_id: uuid.NewString(),
			followed_user_id:  followed_user.ID,
			expectErr:         true,
		},
		{
			name:              "follow self",
			following_user_id: following_user.ID,
			followed_user_id:  following_user.ID,
			expectErr:         true,
		},
	}

	for _, test := range tests {
		p := users.FollowPayload{FollowingUserID: test.following_user_id, FollowedUserID: test.followed_user_id}
		err := s.service.Follow(context.Background(), &p)
		if test.expectErr && err == nil {
			s.T().Errorf("%s: expected err, but got nil", test.name)
		}
		if !test.expectErr && err != nil {
			s.T().Errorf("%s: expected non-error, but got %s", test.name, err)
		}
	}
}

func (s *UsersTestSuite) TestGetFollowers() {
	user_1 := s.create_user("user_1", "User 1")
	user_2 := s.create_user("user_2", "User 2")
	user_3 := s.create_user("user_3", "User 3")

	s.follow(user_2.ID, user_1.ID) // User 2 follows User 1.
	s.follow(user_3.ID, user_1.ID) // User 3 follows User 1.

	tests := []struct {
		name              string
		user_id           string
		expectedFollowers []*users.User
	}{
		{
			name:              "get followers",
			user_id:           user_1.ID,
			expectedFollowers: []*users.User{user_2, user_3},
		},
		{
			name:              "no followers",
			user_id:           user_2.ID,
			expectedFollowers: []*users.User{},
		},
	}

	for _, test := range tests {
		p := users.GetFollowersPayload{ID: test.user_id}
		followers, err := s.service.GetFollowers(context.Background(), &p)
		if err != nil {
			s.T().Fatalf("%s: expected non-error, but got %s", test.name, err)
		}

		// We need to use `reflect.DeepEqual` to compare two slices
		// because the `==` operation is not supported for slices.
		// However, `reflect.DeepEqual` treats a non-nil empty slice and a nil slice as not deeply equal.
		// Therefore, we use `assert.ElementMatch` instead.
		// For more information, see https://golang.org/pkg/reflect/#DeepEqual.
		if !assert.ElementsMatch(s.T(), test.expectedFollowers, followers) {
			s.T().Errorf("%s: expected %+v, but got %+v", test.name, test.expectedFollowers, followers)
		}
	}
}

// TestUsersTestSuite runs all of the tests attached to UsersTestSuite.
func TestUsersTestSuite(t *testing.T) {
	suite.Run(t, new(UsersTestSuite))
}

func (s *UsersTestSuite) create_user(user_name, display_name string) *users.User {
	user, _ := s.service.CreateUser(
		context.Background(),
		&users.CreateUserPayload{
			Username:    user_name,
			DisplayName: display_name,
		},
	)
	return user
}

func (s *UsersTestSuite) follow(following_user_id, followed_user_id string) {
	s.service.Follow(
		context.Background(),
		&users.FollowPayload{
			FollowingUserID: following_user_id,
			FollowedUserID:  followed_user_id,
		},
	)
}
