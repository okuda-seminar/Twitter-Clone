package repository

import "errors"

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
	ErrRecordNotFound  = errors.New("record not found")
	ErrUniqueViolation = errors.New("unique violation")
	ErrRepostViolation = errors.New("repost violation")
)
