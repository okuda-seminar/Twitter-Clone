package repository

import (
	"context"
	"database/sql"
)

// likesRepoImpl implements tweets/repository/lieksRepo.
type likesRepoImpl struct {
	db *sql.DB
}

// NewLikesRepoImpl returns the likes repository implementation.
func NewLikesRepoImpl(db *sql.DB) LikesRepo {
	return &likesRepoImpl{db}
}

// CreateLike creates a new like entry and inserts it into 'likes' table.
func (r *likesRepoImpl) CreateLike(ctx context.Context, tweet_id, user_id string) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/175
	// - Implement LikeTweet API logic.
	return nil
}

// DeleteLike deletes a like entry from 'likes' table.
func (r *likesRepoImpl) DeleteLike(ctx context.Context, tweet_id, user_id string) error {
	// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/193
	// - Implement DeleteTweetLike API logic.
	return nil
}
