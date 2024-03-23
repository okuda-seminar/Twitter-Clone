package tweetsapi

import (
	"log"
	tweets "tweets/gen/tweets"
)

// tweets service example implementation.
// The example methods log the requests and return zero values.
type tweetssrvc struct {
	logger *log.Logger
}

// NewTweets returns the tweets service implementation.
func NewTweets(logger *log.Logger) tweets.Service {
	return &tweetssrvc{logger}
}
