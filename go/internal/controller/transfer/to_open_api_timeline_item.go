package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func toOpenApiPost(item *entity.TimelineItem) *openapi.Post {
	return &openapi.Post{
		AuthorId:  item.AuthorID,
		CreatedAt: item.CreatedAt,
		Id:        item.ID,
		Text:      item.Text,
		Type:      item.Type,
	}
}

func toOpenApiQuoteRepost(item *entity.TimelineItem) *openapi.QuoteRepost {
	return &openapi.QuoteRepost{
		AuthorId:  item.AuthorID,
		CreatedAt: item.CreatedAt,
		Id:        item.ID,
		ParentPostId: struct {
			UUID  string `json:"UUID"`
			Valid bool   `json:"Valid"`
		}{
			UUID:  item.ParentPostID.UUID,
			Valid: item.ParentPostID.Valid,
		},
		Text: item.Text,
		Type: item.Type,
	}
}
