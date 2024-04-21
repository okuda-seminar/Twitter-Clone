package repository

import "context"

type FollowshipsRepo interface {
	CreateFollowship(ctx context.Context, follower_id, followee_id int) error
	DeleteFollowship(ctx context.Context, follower_id, followee_id int) error
}

type Followship struct {
	ID         int
	FollowerID int
	FolloweeID int
}
