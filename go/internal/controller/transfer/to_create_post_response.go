package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToCreatePostResponse(in *entity.TimelineItem) *openapi.CreatePostResponse {
	return &openapi.CreatePostResponse{
		AuthorId:  in.AuthorID,
		CreatedAt: in.CreatedAt,
		Id:        in.ID,
		Text:      in.Text,
		Type:      in.Type,
	}
}
