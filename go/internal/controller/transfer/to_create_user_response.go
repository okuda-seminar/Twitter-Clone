package transfer

import (
	"time"

	openapi_types "github.com/oapi-codegen/runtime/types"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToCreateUserResponse(in *entity.User, token string) *openapi.CreateUserResponse {
	return &openapi.CreateUserResponse{
		Token: token,
		User: struct {
			Bio         string             `json:"bio"`
			CreatedAt   time.Time          `json:"createdAt"`
			DisplayName string             `json:"displayName"`
			Id          openapi_types.UUID `json:"id"`
			IsPrivate   bool               `json:"isPrivate"`
			UpdatedAt   time.Time          `json:"updatedAt"`
			Username    string             `json:"username"`
		}{
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
