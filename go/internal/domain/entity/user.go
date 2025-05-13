package entity

import (
	"time"
)

// User represents an entry of `users` table.
// It contains properties such as Username and DisplayName,
// which are associated with a user's identity
// Username is a unique identifier for a user's account and is preceded by the "@" symbol.
// It's used in the URL of the user's profile
// and is how other users mention or reference them in tweets.
//
// DisplayName is the name that appears on a user's profile and alongside their tweets.
// It doesn't need to be unique and can be changed by the user.
//
// For more information on terminology, refer to: https://help.twitter.com/en/resources/glossary.
type User struct {
	ID          string    `json:"id"`
	Username    string    `json:"username"`
	Password    string    `json:"-"`
	DisplayName string    `json:"displayName"`
	Bio         string    `json:"bio"`
	IsPrivate   bool      `json:"isPrivate"`
	CreatedAt   time.Time `json:"createdAt"`
	UpdatedAt   time.Time `json:"updatedAt"`
}
