package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToLoginResponse(in *entity.User, token string) *openapi.LoginResponse {
	return &openapi.LoginResponse{
		Token: token,
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
