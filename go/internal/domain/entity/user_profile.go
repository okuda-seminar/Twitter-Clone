package entity

// ProfileBaseInfo represents the basic information of a user's profile,
// including the user entity and counts of followees and followers.
type ProfileBaseInfo struct {
	User
	FolloweesCount int64
	FollowersCount int64
}

// UserProfile represents a user's profile information,
// including the base profile information and the count of posts.
type UserProfile struct {
	ProfileBaseInfo
	PostsCount int64
}
