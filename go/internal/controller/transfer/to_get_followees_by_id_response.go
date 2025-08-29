package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToGetFolloweesByIDResponse(followees []entity.User) []openapi.User {
	response := make([]openapi.User, 0, len(followees))

	for _, user := range followees {
		response = append(response, openapi.User{
			Bio:         user.Bio,
			CreatedAt:   user.CreatedAt,
			DisplayName: user.DisplayName,
			Id:          user.ID,
			IsPrivate:   user.IsPrivate,
			UpdatedAt:   user.UpdatedAt,
			Username:    user.Username,
		})
	}

	return response
}
