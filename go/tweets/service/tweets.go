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
	tweetsRepo   repository.TweetsRepo
	likesRepo    repository.LikesRepo
	retweetsRepo repository.RetweetsRepo
	repliesRepo  repository.RepliesRepo
	logger       *log.Logger
}

// NewTweetsSvc returns the tweets service implementation.
func NewTweetsSvc(db *sql.DB, logger *log.Logger) tweets.Service {
	tweetsRepo := repository.NewTweetsRepoImpl(db)
	likesRepo := repository.NewLikesRepoImpl(db)
	retweetsRepo := repository.NewRetweetsRepoImpl(db)
	repliesRepo := repository.NewRepliesRepoImpl(db)
	return &tweetsSvc{tweetsRepo, likesRepo, retweetsRepo, repliesRepo, logger}
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
	return res, nil
}

func (s *tweetsSvc) DeleteTweet(
	ctx context.Context,
	p *tweets.DeleteTweetPayload,
) (err error) {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/134
	// - Discuss how we implement the test for DeleteTweet method.
	id, err := uuid.Parse(p.ID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.DeleteTweet: failed (%s)\n", err)
		return err
	}
	err = s.tweetsRepo.DeleteTweet(ctx, id)
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
	tweetId, err := uuid.Parse(p.TweetID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.LikeTweet: failed (%s)\n", err)
		return err
	}
	userId, err := uuid.Parse(p.UserID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.LikeTweet: failed (%s)\n", err)
		return err
	}
	err = s.likesRepo.CreateLike(ctx, tweetId, userId)
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
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/134
	// - Discuss how we implement the test for DeleteTweetLike method.
	tweetId, err := uuid.Parse(p.TweetID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.DeleteTweetLike: failed (%s)\n", err)
		return err
	}
	userId, err := uuid.Parse(p.UserID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.DeleteTweetLike: failed (%s)\n", err)
		return err
	}
	err = s.likesRepo.DeleteLike(ctx, tweetId, userId)
	if err != nil {
		s.logger.Printf("tweets.DeleteTweetLike: failed (%s)", err)
		return tweets.MakeBadRequest(err)
	}

	s.logger.Print("tweets.DeleteTweetLike")
	return nil
}

func (s *tweetsSvc) Retweet(ctx context.Context, p *tweets.RetweetPayload) error {
	tweetId, err := uuid.Parse(p.TweetID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.Retweet: failed (%s)\n", err)
		return err
	}
	userId, err := uuid.Parse(p.UserID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.Retweet: failed (%s)\n", err)
		return err
	}

	err = s.retweetsRepo.CreateRetweet(ctx, tweetId, userId)
	if err != nil {
		s.logger.Printf("tweets.Retweet: failed (%s)", err)
		return tweets.MakeBadRequest(err)
	}

	s.logger.Print("tweets.Retweet")
	return nil
}

func (s *tweetsSvc) DeleteRetweet(ctx context.Context, p *tweets.DeleteRetweetPayload) error {
	tweetId, err := uuid.Parse(p.TweetID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.DeleteRetweet: failed (%s)\n", err)
		return err
	}
	userId, err := uuid.Parse(p.UserID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.DeleteRetweet: failed (%s)\n", err)
		return err
	}

	err = s.retweetsRepo.DeleteRetweet(ctx, tweetId, userId)
	if err != nil {
		s.logger.Printf("tweets.DeleteRetweet: failed (%s)", err)
		return tweets.MakeBadRequest(err)
	}

	s.logger.Print("tweets.DeleteRetweet")
	return nil
}

func (s *tweetsSvc) CreateReply(ctx context.Context, p *tweets.CreateReplyPayload) (res *tweets.Reply, err error) {
	if !validateReply(p.Text) {
		err := tweets.MakeBadRequest(errors.New("reply is invalid"))
		s.logger.Printf("tweets.CreateReply: failed (%s)\n", err)
		return nil, err
	}

	tweetId, err := uuid.Parse(p.TweetID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.CreateReply: failed (%s)\n", err)
		return nil, err
	}
	userId, err := uuid.Parse(p.UserID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.CreateReply: failed (%s)\n", err)
		return nil, err
	}

	reply, err := s.repliesRepo.CreateReply(ctx, tweetId, userId, p.Text)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.CreateReply: failed (%s)\n", err)
		return nil, err
	}

	res = mapRepoReplyToSvcReply(reply)

	s.logger.Print("tweets.CreateReply")
	return res, nil
}

func (s *tweetsSvc) DeleteReply(ctx context.Context, p *tweets.DeleteReplyPayload) error {
	Id, err := uuid.Parse(p.ID)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.DeleteReply: failed (%s)\n", err)
		return err
	}

	err = s.repliesRepo.DeleteReply(ctx, Id)
	if err != nil {
		err = tweets.MakeBadRequest(err)
		s.logger.Printf("tweets.DeleteReply: failed (%s)", err)
		return err
	}

	s.logger.Print("tweet.DeleteReply")
	return nil
}

// Check whether the length of tweet text is between min and max inclusive.
func validateTweet(text string) bool {
	if len(text) < textLenMin || len(text) > textLenMax {
		return false
	}
	return true
}

// Check whether the length of reply text is between min and max inclusive.
func validateReply(text string) bool {
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

func mapRepoReplyToSvcReply(reply *repository.Reply) *tweets.Reply {
	return &tweets.Reply{
		ID:        reply.Id.String(),
		TweetID:   reply.TweetId.String(),
		UserID:    reply.UserId.String(),
		Text:      reply.Text,
		CreatedAt: reply.CreatedAt.Format(time.RFC3339),
	}
}
