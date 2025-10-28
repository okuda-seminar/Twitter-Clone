package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToGetUserByUserIDResponse(in entity.UserProfile) *openapi.GetUserByUserIdResponse {
	return &openapi.GetUserByUserIdResponse{
		Bio:            in.Bio,
		CreatedAt:      in.CreatedAt,
		DisplayName:    in.DisplayName,
		Id:             in.ID,
		IsPrivate:      in.IsPrivate,
		UpdatedAt:      in.UpdatedAt,
		Username:       in.Username,
		FollowersCount: in.FollowersCount,
		FolloweesCount: in.FolloweesCount,
		PostsCount:     in.PostsCount,
	}
}
