package transfer

import (
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func toOpenAPIPost(item *entity.TimelineItem) openapi.Post {
	return openapi.Post{
		AuthorId:  item.AuthorID,
		CreatedAt: item.CreatedAt,
		Id:        item.ID,
		Text:      item.Text,
		Type:      item.Type,
	}
}

func toOpenAPIQuoteRepost(item *entity.TimelineItem) openapi.QuoteRepost {
	return openapi.QuoteRepost{
		AuthorId:  item.AuthorID,
		CreatedAt: item.CreatedAt,
		Id:        item.ID,
		ParentPostId: struct {
			UUID  string `json:"UUID"`
			Valid bool   `json:"Valid"`
		}(item.ParentPostID),
		Text: item.Text,
		Type: item.Type,
	}
}
