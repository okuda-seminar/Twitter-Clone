package transfer

import (
	"encoding/json"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToGetPostByPostIdResponse(timelineItem *entity.TimelineItem, parentTimelineItem *entity.TimelineItem) (*openapi.GetPostByPostIdResponse, error) {
	var parentPost *openapi.ParentPost
	if parentTimelineItem != nil {
		parent, err := parentTimelineItemToJson(parentTimelineItem)
		if err != nil {
			return &openapi.GetPostByPostIdResponse{}, err
		}

		parentPost = openapi.JsonToParentPost(parent)
	}
	var response any
	switch timelineItem.Type {
	case entity.PostTypePost:
		response = toOpenApiPost(timelineItem)
	case entity.PostTypeRepost:
		response = &openapi.RepostWithParent{
			AuthorId:   timelineItem.AuthorID,
			CreatedAt:  timelineItem.CreatedAt,
			Id:         timelineItem.ID,
			ParentPost: parentPost,
			ParentPostId: struct {
				UUID  string `json:"UUID"`
				Valid bool   `json:"Valid"`
			}{
				UUID:  timelineItem.ParentPostID.UUID,
				Valid: timelineItem.ParentPostID.Valid,
			},
			Type: timelineItem.Type,
		}
	case entity.PostTypeQuoteRepost:
		response = &openapi.QuoteRepostWithParent{
			AuthorId:   timelineItem.AuthorID,
			CreatedAt:  timelineItem.CreatedAt,
			Id:         timelineItem.ID,
			ParentPost: parentPost,
			ParentPostId: struct {
				UUID  string `json:"UUID"`
				Valid bool   `json:"Valid"`
			}{
				UUID:  timelineItem.ParentPostID.UUID,
				Valid: timelineItem.ParentPostID.Valid,
			},
			Text: timelineItem.Text,
			Type: timelineItem.Type,
		}
	}

	jsonBytes, err := json.Marshal(response)
	if err != nil {
		return &openapi.GetPostByPostIdResponse{}, err
	}

	return openapi.JsonToGetPostByPostIdResponse(jsonBytes), nil
}

func parentTimelineItemToJson(parentTimelineItem *entity.TimelineItem) (json.RawMessage, error) {
	var parent any
	switch parentTimelineItem.Type {
	case entity.PostTypePost:
		parent = toOpenApiPost(parentTimelineItem)
	case entity.PostTypeQuoteRepost:
		parent = toOpenApiQuoteRepost(parentTimelineItem)
	}

	jsonBytes, err := json.Marshal(parent)
	if err != nil {
		return nil, err
	}

	return jsonBytes, nil
}
