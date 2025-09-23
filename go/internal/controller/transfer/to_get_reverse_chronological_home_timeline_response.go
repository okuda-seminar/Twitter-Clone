package transfer

import (
	"fmt"

	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

// ToGetReverseChronologicalHomeTimelineResponse converts entity.TimelineItem slice to GetReverseChronologicalHomeTimelineResponse
func ToGetReverseChronologicalHomeTimelineResponse(timelineItems []*entity.TimelineItem) (*openapi.GetReverseChronologicalHomeTimelineResponse, error) {
	response := make(openapi.GetReverseChronologicalHomeTimelineResponse, len(timelineItems))

	for i, item := range timelineItems {
		responseItem := openapi.GetReverseChronologicalHomeTimelineResponse_Item{}

		switch item.Type {
		case entity.PostTypePost:
			post := toOpenAPIPost(item)
			responseItem.FromPost(post)
		case entity.PostTypeRepost:
			repost := toOpenAPIRepost(item)
			responseItem.FromRepost(repost)
		case entity.PostTypeQuoteRepost:
			quoteRepost := toOpenAPIQuoteRepost(item)
			responseItem.FromQuoteRepost(quoteRepost)
		default:
			return nil, fmt.Errorf("unsupported post type: %s", item.Type)
		}

		response[i] = responseItem
	}

	return &response, nil
}
