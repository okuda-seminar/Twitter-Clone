package transfer

import (
	"time"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToLoginResponse(in *entity.User, token string) *openapi.LoginResponse {
	return &openapi.LoginResponse{
		Token: token,
		User: struct {
			Bio         string    `json:"bio"`
			CreatedAt   time.Time `json:"created_at"`
			DisplayName string    `json:"display_name"`
			Id          string    `json:"id"`
			IsPrivate   bool      `json:"is_private"`
			UpdatedAt   time.Time `json:"updated_at"`
			Username    string    `json:"username"`
		}{
			Bio:         in.Bio,
			CreatedAt:   in.CreatedAt,
			DisplayName: in.DisplayName,
			Id:          in.ID.String(),
			IsPrivate:   in.IsPrivate,
			UpdatedAt:   in.UpdatedAt,
			Username:    in.Username,
		},
	}
}
