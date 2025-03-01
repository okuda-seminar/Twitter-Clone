package transfers

import (
	"time"
	"x-clone-backend/internal/domain/entities"
	openapi "x-clone-backend/openapi"
)

func ToCreateUserResponse(in *entities.User, token string) *openapi.CreateUserResponse {
	return &openapi.CreateUserResponse{
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
