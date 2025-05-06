package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToVerifySessionResponse(in *entity.User) *openapi.VerifySessionResponse {
	return &openapi.VerifySessionResponse{
		User: openapi.User{
			Bio:         in.Bio,
			CreatedAt:   in.CreatedAt,
			DisplayName: in.DisplayName,
			Id:          in.ID,
			IsPrivate:   in.IsPrivate,
			UpdatedAt:   in.UpdatedAt,
			Username:    in.Username,
		},
	}
}
