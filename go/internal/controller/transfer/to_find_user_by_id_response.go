package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToFindUserByIDResponse(in *entity.User) *openapi.FindUserByIdResponse {
	return &openapi.FindUserByIdResponse{
		Bio:         in.Bio,
		CreatedAt:   in.CreatedAt,
		DisplayName: in.DisplayName,
		Id:          in.ID,
		IsPrivate:   in.IsPrivate,
		UpdatedAt:   in.UpdatedAt,
		Username:    in.Username,
	}
}
