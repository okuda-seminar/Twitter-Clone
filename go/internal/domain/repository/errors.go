package repository

import "errors"

// These constants are used as keys in the `errors` map
// of the fake repository to simulate operation-specific errors during testing.
const (
	ErrKeySpecificUserPosts    = "SpecificUserPosts"
	ErrKeyUserAndFolloweePosts = "UserAndFolloweePosts"
	ErrKeyCreatePost           = "CreatePost"
	ErrKeyDeletePost           = "DeletePost"
	ErrKeyCreateRepost         = "CreateRepost"
	ErrKeyDeleteRepost         = "DeleteRepost"
	ErrKeyCreateQuoteRepost    = "CreateQuoteRepost"
)

var (
	ErrRecordNotFound   = errors.New("record not found")
	ErrUniqueViolation  = errors.New("unique violation")
	ErrForeignViolation = errors.New("foreign violation")
)
