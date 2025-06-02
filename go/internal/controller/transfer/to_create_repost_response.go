package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToCreateRepostResponse(in *entity.TimelineItem) *openapi.CreateRepostResponse {
	return &openapi.CreateRepostResponse{
		AuthorId:  in.AuthorID,
		CreatedAt: in.CreatedAt,
		Id:        in.ID,
		ParentPostId: struct {
			UUID  string `json:"UUID"`
			Valid bool   `json:"Valid"`
		}{
			UUID:  in.ParentPostID.UUID,
			Valid: in.ParentPostID.Valid,
		},
		Type: in.Type,
	}
}
