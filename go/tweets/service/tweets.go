package service

import (
	"context"
	"database/sql"
	"errors"
	"log"
	"time"
	"tweets/db/repository"
	"tweets/gen/tweets"

	"github.com/google/uuid"
)

const (
	textLenMin int = 1
	textLenMax int = 140
)

// tweetsSvc implements tweets/gen/tweets.Service.
type tweetsSvc struct {
	tweetsRepo repository.TweetsRepo
	likesRepo  repository.LikesRepo
	logger     *log.Logger
}

// NewTweetsSvc returns the tweets service implementation.
func NewTweetsSvc(db *sql.DB, logger *log.Logger) tweets.Service {
	tweetsRepo := repository.NewTweetsRepoImpl(db)
	likesRepo := repository.NewLikesRepoImpl(db)
	return &tweetsSvc{tweetsRepo, likesRepo, logger}
}

// CreateTweet creates a tweet posted by a user with the specified ID.
// Returns the created tweet with 200 OK when all the processes succeed, otherwise returns 400 Bad Request.
func (s *tweetsSvc) CreateTweet(
	ctx context.Context,
	p *tweets.CreateTweetPayload,
) (res *tweets.Tweet, err error) {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/134
	// - Discuss how we implement the test for CreateTweet method.
	if !validateTweet(p.Text) {
		err = tweets.MakeBadRequest(errors.New("tweet is invalid"))
		s.logger.Printf("tweets.CreateTweet: failed (%s)\n", err)
		return nil, err
	}

	userId, err := uuid.Parse(p.UserID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.CreateTweet: failed (%s)\n", err)
		return nil, err
	}

	tweet, err := s.tweetsRepo.CreateTweet(ctx, userId, p.Text)
	if err != nil {
		s.logger.Printf("tweets.CreateTweet: failed (%s)", err)
		return nil, tweets.MakeBadRequest(err)
	}

	res = mapRepoTweetToSvcTweet(tweet)

	s.logger.Print("tweets.CreateTweet")
	return
}

func (s *tweetsSvc) DeleteTweet(
	ctx context.Context,
	p *tweets.DeleteTweetPayload,
) (err error) {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/134
	// - Discuss how we implement the test for DeleteTweet method.
	err = s.tweetsRepo.DeleteTweet(ctx, p.ID)
	if err != nil {
		s.logger.Printf("tweets.DeleteTweet: failed (%s)", err)
		return tweets.MakeBadRequest(err)
	}

	s.logger.Printf("tweets.DeleteTweet")
	return
}

// LikeTweet handles the action of a user liking a tweet.
// Returns 200 OK when all the processes succeed, otherwise returns 400 Bad Request.
func (s *tweetsSvc) LikeTweet(ctx context.Context, p *tweets.LikeTweetPayload) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/134
	// - Discuss how we implement the test for LikeTweet method.
	err := s.likesRepo.CreateLike(ctx, p.TweetID, p.UserID)
	if err != nil {
		s.logger.Printf("tweets.LikeTweet: failed (%s)", err)
		return tweets.MakeBadRequest(err)
	}

	s.logger.Print("tweets.LikeTweet")
	return nil
}

// DeleteTweetLike handles the action of a user deleting a tweet like.
// Returns 200 OK when all the processes succeed, otherwise returns 400 Bad Request.
func (s *tweetsSvc) DeleteTweetLike(ctx context.Context, p *tweets.DeleteTweetLikePayload) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/193
	// - Implement DeleteTweetLike API logic.
	return nil
}

// Check whether the length of tweet text is between min and max inclusive.
func validateTweet(text string) bool {
	if len(text) < textLenMin || len(text) > textLenMax {
		return false
	}
	return true
}

func mapRepoTweetToSvcTweet(tweet *repository.Tweet) *tweets.Tweet {
	return &tweets.Tweet{
		ID:        tweet.Id.String(),
		UserID:    tweet.UserId.String(),
		Text:      tweet.Text,
		CreatedAt: tweet.CreatedAt.Format(time.RFC3339),
	}
}
