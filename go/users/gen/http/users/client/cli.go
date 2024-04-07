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
	"strconv"
	users "users/gen/users"
)

// BuildCreateUserPayload builds the payload for the users CreateUser endpoint
// from CLI flags.
func BuildCreateUserPayload(usersCreateUserBody string) (*users.CreateUserPayload, error) {
	var err error
	var body CreateUserRequestBody
	{
		err = json.Unmarshal([]byte(usersCreateUserBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"username\": \"Ipsam in eos et asperiores.\"\n   }'")
		}
	}
	v := &users.CreateUserPayload{
		Username: body.Username,
	}

	return v, nil
}

// BuildDeleteUserPayload builds the payload for the users DeleteUser endpoint
// from CLI flags.
func BuildDeleteUserPayload(usersDeleteUserBody string) (*users.DeleteUserPayload, error) {
	var err error
	var body DeleteUserRequestBody
	{
		err = json.Unmarshal([]byte(usersDeleteUserBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"id\": 3003530445289903022\n   }'")
		}
	}
	v := &users.DeleteUserPayload{
		ID: body.ID,
	}

	return v, nil
}

// BuildFindUserByIDPayload builds the payload for the users FindUserByID
// endpoint from CLI flags.
func BuildFindUserByIDPayload(usersFindUserByIDID string) (*users.FindUserByIDPayload, error) {
	var err error
	var id int
	{
		var v int64
		v, err = strconv.ParseInt(usersFindUserByIDID, 10, strconv.IntSize)
		id = int(v)
		if err != nil {
			return nil, fmt.Errorf("invalid value for id, must be INT")
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
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"username\": \"Ipsum error nostrum.\"\n   }'")
		}
	}
	var id int
	{
		var v int64
		v, err = strconv.ParseInt(usersUpdateUsernameID, 10, strconv.IntSize)
		id = int(v)
		if err != nil {
			return nil, fmt.Errorf("invalid value for id, must be INT")
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
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"bio\": \"Accusantium aut autem molestias placeat.\"\n   }'")
		}
	}
	var id int
	{
		var v int64
		v, err = strconv.ParseInt(usersUpdateBioID, 10, strconv.IntSize)
		id = int(v)
		if err != nil {
			return nil, fmt.Errorf("invalid value for id, must be INT")
		}
	}
	v := &users.UpdateBioPayload{
		Bio: body.Bio,
	}
	v.ID = id

	return v, nil
}
