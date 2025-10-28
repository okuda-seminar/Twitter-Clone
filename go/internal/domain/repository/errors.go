package repository

import "errors"

// These constants are used as keys in the `errors` map
// of the fake repository to simulate operation-specific errors during testing.
const (
	// Timeline Items
	ErrKeySpecificUserPosts    = "SpecificUserPosts"
	ErrKeyUserAndFolloweePosts = "UserAndFolloweePosts"
	ErrKeyCreatePost           = "CreatePost"
	ErrKeyDeletePost           = "DeletePost"
	ErrKeyCreateRepost         = "CreateRepost"
	ErrKeyDeleteRepost         = "DeleteRepost"
	ErrKeyCreateQuoteRepost    = "CreateQuoteRepost"
	ErrKeyRetrieveTimelineItem = "RetrieveTimelineItem"
	ErrKeyCountPosts           = "CountPosts"

	// Users Items
	ErrKeyCreateUser     = "CreateUser"
	ErrKeyDeleteUserByID = "DeleteUserByID"
	ErrKeyUserByUserID   = "UserByUserID"
	ErrKeyUserByUsername = "UserByUsername"
	ErrKeyLikePost       = "LikePost"
	ErrKeyUnlikePost     = "UnlikePost"
	ErrKeyFollowUser     = "FollowUser"
	ErrKeyUnfollowUser   = "UnfollowUser"
	ErrKeyMuteUser       = "MuteUser"
	ErrKeyUnmuteUser     = "UnmuteUser"
	ErrKeyBlockUser      = "BlockUser"
	ErrKeyUnblockUser    = "UnblockUser"
	ErrKeyFollowersByID  = "FollowersByID"
	ErrKeyFolloweesByID  = "FolloweesByID"
)

var (
	ErrRecordNotFound   = errors.New("record not found")
	ErrUniqueViolation  = errors.New("unique violation")
	ErrForeignViolation = errors.New("foreign violation")
)
