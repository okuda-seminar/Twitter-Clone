// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets HTTP client CLI support package
//
// Command:
// $ goa gen tweets/design

package client

import (
	"encoding/json"
	"fmt"
	tweets "tweets/gen/tweets"
)

// BuildCreateTweetPayload builds the payload for the tweets CreateTweet
// endpoint from CLI flags.
func BuildCreateTweetPayload(tweetsCreateTweetBody string) (*tweets.CreateTweetPayload, error) {
	var err error
	var body CreateTweetRequestBody
	{
		err = json.Unmarshal([]byte(tweetsCreateTweetBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"text\": \"Voluptas omnis nesciunt incidunt et totam eos.\",\n      \"user_id\": \"Mollitia similique corporis.\"\n   }'")
		}
	}
	v := &tweets.CreateTweetPayload{
		UserID: body.UserID,
		Text:   body.Text,
	}

	return v, nil
}

// BuildLikeTweetPayload builds the payload for the tweets LikeTweet endpoint
// from CLI flags.
func BuildLikeTweetPayload(tweetsLikeTweetBody string) (*tweets.LikeTweetPayload, error) {
	var err error
	var body LikeTweetRequestBody
	{
		err = json.Unmarshal([]byte(tweetsLikeTweetBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"tweet_id\": \"Nostrum labore tempore officiis explicabo id.\",\n      \"user_id\": \"Dolores et.\"\n   }'")
		}
	}
	v := &tweets.LikeTweetPayload{
		TweetID: body.TweetID,
		UserID:  body.UserID,
	}

	return v, nil
}

// BuildDeleteTweetLikePayload builds the payload for the tweets
// DeleteTweetLike endpoint from CLI flags.
func BuildDeleteTweetLikePayload(tweetsDeleteTweetLikeBody string) (*tweets.DeleteTweetLikePayload, error) {
	var err error
	var body DeleteTweetLikeRequestBody
	{
		err = json.Unmarshal([]byte(tweetsDeleteTweetLikeBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"tweet_id\": \"Ducimus nobis tenetur illo iste quo.\",\n      \"user_id\": \"Assumenda enim.\"\n   }'")
		}
	}
	v := &tweets.DeleteTweetLikePayload{
		TweetID: body.TweetID,
		UserID:  body.UserID,
	}

	return v, nil
}
