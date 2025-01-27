// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets service
//
// Command:
// $ goa gen tweets/design

package tweets

import (
	"context"

	goa "goa.design/goa/v3/pkg"
)

// The tweets service performs operations on tweets information.
type Service interface {
	// CreatePost implements CreatePost.
	CreatePost(context.Context, *CreatePostPayload) (res *Tweet, err error)
	// DeleteTweet implements DeleteTweet.
	DeleteTweet(context.Context, *DeleteTweetPayload) (err error)
	// LikeTweet implements LikeTweet.
	LikeTweet(context.Context, *LikeTweetPayload) (err error)
	// DeleteTweetLike implements DeleteTweetLike.
	DeleteTweetLike(context.Context, *DeleteTweetLikePayload) (err error)
	// Retweet implements Retweet.
	Retweet(context.Context, *RetweetPayload) (err error)
	// DeleteRetweet implements DeleteRetweet.
	DeleteRetweet(context.Context, *DeleteRetweetPayload) (err error)
	// CreateReply implements CreateReply.
	CreateReply(context.Context, *CreateReplyPayload) (res *Reply, err error)
	// DeleteReply implements DeleteReply.
	DeleteReply(context.Context, *DeleteReplyPayload) (err error)
}

// APIName is the name of the API as defined in the design.
const APIName = "tweets"

// APIVersion is the version of the API as defined in the design.
const APIVersion = "0.0.1"

// ServiceName is the name of the service as defined in the design. This is the
// same value that is set in the endpoint request contexts under the ServiceKey
// key.
const ServiceName = "tweets"

// MethodNames lists the service method names as defined in the design. These
// are the same values that are set in the endpoint request contexts under the
// MethodKey key.
var MethodNames = [8]string{"CreatePost", "DeleteTweet", "LikeTweet", "DeleteTweetLike", "Retweet", "DeleteRetweet", "CreateReply", "DeleteReply"}

// CreatePostPayload is the payload type of the tweets service CreatePost
// method.
type CreatePostPayload struct {
	UserID string
	Text   string
}

// CreateReplyPayload is the payload type of the tweets service CreateReply
// method.
type CreateReplyPayload struct {
	TweetID string
	UserID  string
	Text    string
}

// DeleteReplyPayload is the payload type of the tweets service DeleteReply
// method.
type DeleteReplyPayload struct {
	ID string
}

// DeleteRetweetPayload is the payload type of the tweets service DeleteRetweet
// method.
type DeleteRetweetPayload struct {
	TweetID string
	UserID  string
}

// DeleteTweetLikePayload is the payload type of the tweets service
// DeleteTweetLike method.
type DeleteTweetLikePayload struct {
	TweetID string
	UserID  string
}

// DeleteTweetPayload is the payload type of the tweets service DeleteTweet
// method.
type DeleteTweetPayload struct {
	ID string
}

// LikeTweetPayload is the payload type of the tweets service LikeTweet method.
type LikeTweetPayload struct {
	TweetID string
	UserID  string
}

// Reply is the result type of the tweets service CreateReply method.
type Reply struct {
	ID        string
	TweetID   string
	UserID    string
	Text      string
	CreatedAt string
}

// RetweetPayload is the payload type of the tweets service Retweet method.
type RetweetPayload struct {
	TweetID string
	UserID  string
}

// Tweet is the result type of the tweets service CreatePost method.
type Tweet struct {
	ID        string
	UserID    string
	Text      string
	CreatedAt string
}

// MakeNotFound builds a goa.ServiceError from an error.
func MakeNotFound(err error) *goa.ServiceError {
	return goa.NewServiceError(err, "NotFound", false, false, false)
}

// MakeBadRequest builds a goa.ServiceError from an error.
func MakeBadRequest(err error) *goa.ServiceError {
	return goa.NewServiceError(err, "BadRequest", false, false, false)
}
