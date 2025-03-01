package errors

import "errors"

var ErrUserNotFound = errors.New("user not found")
var ErrLikeNotFound = errors.New("like not found")
var ErrFollowshipNotFound = errors.New("followship not found")
var ErrMuteNotFound = errors.New("mute not found")
var ErrBlockNotFound = errors.New("block not found")
