package service

import (
	"context"
	"database/sql"
	"log"
	"tweets/db/repository"
	"tweets/gen/tweets"
)

// tweetsSvc implements tweets/gen/tweets.Service.
type tweetsSvc struct {
	repository repository.TweetsRepo
	logger     *log.Logger
}

// NewTweetsSvc returns the tweets service implementation.
func NewTweetsSvc(db *sql.DB, logger *log.Logger) tweets.Service {
	repository := repository.NewTweetsRepoImpl(db)
	return &tweetsSvc{repository, logger}
}

// CreateTweet creates a tweet posted by a user with the specified ID.
// The length of a tweet's text must be between 1 and 140 inclusive.
func (s *tweetsSvc) CreateTweet(
	ctx context.Context,
	payload *tweets.CreateTweetPayload,
) (*tweets.Tweet, error) {
	// TODO
	return nil, nil
}
