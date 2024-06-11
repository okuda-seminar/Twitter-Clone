// Code generated by goa v3.14.0, DO NOT EDIT.
//
// users HTTP client CLI support package
//
// Command:
// $ goa gen users/design

package client

import (
	"encoding/json"
	"fmt"
	users "users/gen/users"

	goa "goa.design/goa/v3/pkg"
)

// BuildCreateUserPayload builds the payload for the users CreateUser endpoint
// from CLI flags.
func BuildCreateUserPayload(usersCreateUserBody string) (*users.CreateUserPayload, error) {
	var err error
	var body CreateUserRequestBody
	{
		err = json.Unmarshal([]byte(usersCreateUserBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"display_name\": \"Saepe sit.\",\n      \"username\": \"Non vitae.\"\n   }'")
		}
	}
	v := &users.CreateUserPayload{
		Username:    body.Username,
		DisplayName: body.DisplayName,
	}

	return v, nil
}

// BuildDeleteUserPayload builds the payload for the users DeleteUser endpoint
// from CLI flags.
func BuildDeleteUserPayload(usersDeleteUserID string) (*users.DeleteUserPayload, error) {
	var err error
	var id string
	{
		id = usersDeleteUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("id", id, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.DeleteUserPayload{}
	v.ID = id

	return v, nil
}

// BuildFindUserByIDPayload builds the payload for the users FindUserByID
// endpoint from CLI flags.
func BuildFindUserByIDPayload(usersFindUserByIDID string) (*users.FindUserByIDPayload, error) {
	var err error
	var id string
	{
		id = usersFindUserByIDID
		err = goa.MergeErrors(err, goa.ValidateFormat("id", id, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.FindUserByIDPayload{}
	v.ID = id

	return v, nil
}

// BuildUpdateUsernamePayload builds the payload for the users UpdateUsername
// endpoint from CLI flags.
func BuildUpdateUsernamePayload(usersUpdateUsernameBody string, usersUpdateUsernameID string) (*users.UpdateUsernamePayload, error) {
	var err error
	var body UpdateUsernameRequestBody
	{
		err = json.Unmarshal([]byte(usersUpdateUsernameBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"username\": \"Nihil molestias saepe ipsam debitis illo ullam.\"\n   }'")
		}
	}
	var id string
	{
		id = usersUpdateUsernameID
		err = goa.MergeErrors(err, goa.ValidateFormat("id", id, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.UpdateUsernamePayload{
		Username: body.Username,
	}
	v.ID = id

	return v, nil
}

// BuildUpdateBioPayload builds the payload for the users UpdateBio endpoint
// from CLI flags.
func BuildUpdateBioPayload(usersUpdateBioBody string, usersUpdateBioID string) (*users.UpdateBioPayload, error) {
	var err error
	var body UpdateBioRequestBody
	{
		err = json.Unmarshal([]byte(usersUpdateBioBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"bio\": \"Expedita dolor suscipit deleniti ab sit laudantium.\"\n   }'")
		}
	}
	var id string
	{
		id = usersUpdateBioID
		err = goa.MergeErrors(err, goa.ValidateFormat("id", id, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.UpdateBioPayload{
		Bio: body.Bio,
	}
	v.ID = id

	return v, nil
}

// BuildFollowPayload builds the payload for the users Follow endpoint from CLI
// flags.
func BuildFollowPayload(usersFollowBody string, usersFollowFollowingUserID string) (*users.FollowPayload, error) {
	var err error
	var body FollowRequestBody
	{
		err = json.Unmarshal([]byte(usersFollowBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"followed_user_id\": \"86a86a0d-27ea-11ef-8ab2-0242ac120003\"\n   }'")
		}
		err = goa.MergeErrors(err, goa.ValidateFormat("body.followed_user_id", body.FollowedUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	var followingUserID string
	{
		followingUserID = usersFollowFollowingUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("following_user_id", followingUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.FollowPayload{
		FollowedUserID: body.FollowedUserID,
	}
	v.FollowingUserID = followingUserID

	return v, nil
}

// BuildUnfollowPayload builds the payload for the users Unfollow endpoint from
// CLI flags.
func BuildUnfollowPayload(usersUnfollowFollowingUserID string, usersUnfollowFollowedUserID string) (*users.UnfollowPayload, error) {
	var err error
	var followingUserID string
	{
		followingUserID = usersUnfollowFollowingUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("following_user_id", followingUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	var followedUserID string
	{
		followedUserID = usersUnfollowFollowedUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("followed_user_id", followedUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.UnfollowPayload{}
	v.FollowingUserID = followingUserID
	v.FollowedUserID = followedUserID

	return v, nil
}

// BuildGetFollowersPayload builds the payload for the users GetFollowers
// endpoint from CLI flags.
func BuildGetFollowersPayload(usersGetFollowersID string) (*users.GetFollowersPayload, error) {
	var err error
	var id string
	{
		id = usersGetFollowersID
		err = goa.MergeErrors(err, goa.ValidateFormat("id", id, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.GetFollowersPayload{}
	v.ID = id

	return v, nil
}

// BuildGetFollowingsPayload builds the payload for the users GetFollowings
// endpoint from CLI flags.
func BuildGetFollowingsPayload(usersGetFollowingsID string) (*users.GetFollowingsPayload, error) {
	var err error
	var id string
	{
		id = usersGetFollowingsID
		err = goa.MergeErrors(err, goa.ValidateFormat("id", id, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.GetFollowingsPayload{}
	v.ID = id

	return v, nil
}

// BuildMutePayload builds the payload for the users Mute endpoint from CLI
// flags.
func BuildMutePayload(usersMuteBody string, usersMuteMutingUserID string) (*users.MutePayload, error) {
	var err error
	var body MuteRequestBody
	{
		err = json.Unmarshal([]byte(usersMuteBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"muted_user_id\": \"86a8a487-27ea-11ef-8ab2-0242ac120003\"\n   }'")
		}
		err = goa.MergeErrors(err, goa.ValidateFormat("body.muted_user_id", body.MutedUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	var mutingUserID string
	{
		mutingUserID = usersMuteMutingUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("muting_user_id", mutingUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.MutePayload{
		MutedUserID: body.MutedUserID,
	}
	v.MutingUserID = mutingUserID

	return v, nil
}

// BuildUnmutePayload builds the payload for the users Unmute endpoint from CLI
// flags.
func BuildUnmutePayload(usersUnmuteMutingUserID string, usersUnmuteMutedUserID string) (*users.UnmutePayload, error) {
	var err error
	var mutingUserID string
	{
		mutingUserID = usersUnmuteMutingUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("muting_user_id", mutingUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	var mutedUserID string
	{
		mutedUserID = usersUnmuteMutedUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("muted_user_id", mutedUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.UnmutePayload{}
	v.MutingUserID = mutingUserID
	v.MutedUserID = mutedUserID

	return v, nil
}

// BuildBlockPayload builds the payload for the users Block endpoint from CLI
// flags.
func BuildBlockPayload(usersBlockBody string, usersBlockBlockingUserID string) (*users.BlockPayload, error) {
	var err error
	var body BlockRequestBody
	{
		err = json.Unmarshal([]byte(usersBlockBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"blocked_user_id\": \"86a8f8b2-27ea-11ef-8ab2-0242ac120003\"\n   }'")
		}
		err = goa.MergeErrors(err, goa.ValidateFormat("body.blocked_user_id", body.BlockedUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	var blockingUserID string
	{
		blockingUserID = usersBlockBlockingUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("blocking_user_id", blockingUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.BlockPayload{
		BlockedUserID: body.BlockedUserID,
	}
	v.BlockingUserID = blockingUserID

	return v, nil
}

// BuildUnblockPayload builds the payload for the users Unblock endpoint from
// CLI flags.
func BuildUnblockPayload(usersUnblockBlockingUserID string, usersUnblockBlockedUserID string) (*users.UnblockPayload, error) {
	var err error
	var blockingUserID string
	{
		blockingUserID = usersUnblockBlockingUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("blocking_user_id", blockingUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	var blockedUserID string
	{
		blockedUserID = usersUnblockBlockedUserID
		err = goa.MergeErrors(err, goa.ValidateFormat("blocked_user_id", blockedUserID, goa.FormatUUID))
		if err != nil {
			return nil, err
		}
	}
	v := &users.UnblockPayload{}
	v.BlockingUserID = blockingUserID
	v.BlockedUserID = blockedUserID

	return v, nil
}
