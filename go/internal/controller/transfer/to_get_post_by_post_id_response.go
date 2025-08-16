package transfer

import (
	"fmt"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

func ToGetPostByPostIdResponse(timelineItem *entity.TimelineItem, parentTimelineItem *entity.TimelineItem) (*openapi.GetPostByPostIdResponse, error) {
	var parentPost openapi.ParentPost
	if parentTimelineItem != nil {
		switch parentTimelineItem.Type {
		case entity.PostTypePost:
			err := parentPost.MergePost(toOpenAPIPost(parentTimelineItem))
			if err != nil {
				return nil, err
			}
		case entity.PostTypeQuoteRepost:
			err := parentPost.MergeQuoteRepost(toOpenAPIQuoteRepost(parentTimelineItem))
			if err != nil {
				return nil, err
			}
		default:
			return nil, fmt.Errorf("unsupported post type")
		}
	}

	var getPostByPostIdResponse openapi.GetPostByPostIdResponse
	switch timelineItem.Type {
	case entity.PostTypePost:
		post := toOpenAPIPost(timelineItem)
		err := getPostByPostIdResponse.MergePost(post)
		return &getPostByPostIdResponse, err
	case entity.PostTypeRepost:
		repostWithParentPost := openapi.RepostWithParent{
			AuthorId:   timelineItem.AuthorID,
			CreatedAt:  timelineItem.CreatedAt,
			Id:         timelineItem.ID,
			ParentPost: &parentPost,
			ParentPostId: struct {
				UUID  string `json:"UUID"`
				Valid bool   `json:"Valid"`
			}(timelineItem.ParentPostID),
			Type: timelineItem.Type,
		}
		err := getPostByPostIdResponse.MergeRepostWithParent(repostWithParentPost)
		return &getPostByPostIdResponse, err
	case entity.PostTypeQuoteRepost:
		response := openapi.QuoteRepostWithParent{
			AuthorId:   timelineItem.AuthorID,
			CreatedAt:  timelineItem.CreatedAt,
			Id:         timelineItem.ID,
			ParentPost: &parentPost,
			ParentPostId: struct {
				UUID  string `json:"UUID"`
				Valid bool   `json:"Valid"`
			}(timelineItem.ParentPostID),
			Text: timelineItem.Text,
			Type: timelineItem.Type,
		}

		err := getPostByPostIdResponse.MergeQuoteRepostWithParent(response)
		return &getPostByPostIdResponse, err
	default:
		return nil, fmt.Errorf("unsupported post type")
	}
}
