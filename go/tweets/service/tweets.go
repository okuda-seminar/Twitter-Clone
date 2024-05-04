package service

import (
	"context"
	"database/sql"
	"errors"
	"log"
	"time"
	"tweets/db/repository"
	"tweets/gen/tweets"
)

const (
	textLenMin int = 1
	textLenMax int = 140
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
// returns the created tweet with 200 OK when all the processes succeed, otherwise returns 400 Bad Request.
func (s *tweetsSvc) CreateTweet(
	ctx context.Context,
	p *tweets.CreateTweetPayload,
) (res *tweets.Tweet, err error) {
	if !validateTweet(p.Text) {
		err = tweets.MakeBadRequest(errors.New("tweet is invalid"))
		s.logger.Printf("tweets.CreateTweet: failed (%s)", err)
		return nil, err
	}

	tweet, err := s.repository.CreateTweet(ctx, p.UserID, p.Text)
	if err != nil {
		s.logger.Printf("tweets.CreateTweet: failed (%s)", err)
		return nil, tweets.MakeBadRequest(err)
	}

	res = &tweets.Tweet{
		ID:        tweet.Id,
		UserID:    tweet.UserId,
		Text:      tweet.Text,
		CreatedAt: tweet.CreatedAt.Format(time.RFC3339),
	}

	s.logger.Print("tweets.CreateTweet")
	return
}

// Check whether the length of tweet text is between min and max inclusive.
func validateTweet(text string) bool {
	if len(text) < textLenMin || len(text) > textLenMax {
		return false
	}
	return true
}
