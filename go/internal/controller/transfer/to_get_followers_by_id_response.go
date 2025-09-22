package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToGetFollowersByIDResponse(followers []entity.User) []openapi.User {
	response := make([]openapi.User, 0, len(followers))

	for _, user := range followers {
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
