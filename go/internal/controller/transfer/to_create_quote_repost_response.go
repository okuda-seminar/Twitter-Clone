package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToCreateQuoteRepostResponse(in *entity.TimelineItem) *openapi.CreateQuoteRepostResponse {
	return &openapi.CreateQuoteRepostResponse{
		AuthorId:  in.AuthorID,
		CreatedAt: in.CreatedAt,
		Id:        in.ID,
		ParentPostId: struct {
			UUID  string "json:\"UUID\""
			Valid bool   "json:\"Valid\""
		}(in.ParentPostID),
		Text: in.Text,
		Type: in.Type,
	}
}
