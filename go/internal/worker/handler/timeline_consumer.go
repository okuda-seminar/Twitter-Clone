package handler

import (
	"context"
	"encoding/json"
	"fmt"
	"log"

	"x-clone-backend/internal/config"
	"x-clone-backend/internal/domain/messaging"
	"x-clone-backend/internal/worker/usecase/api"
)

const (
	TopicTimelineItem = "timelineItem"
	GroupID           = "timeline-cache-worker"
)

func ConsumeTimelineItems(ctx context.Context, u api.TimelineUsecase) {
	r := config.OpenKafkaReader(TopicTimelineItem, GroupID)
	defer r.Close()

	log.Printf("Started consuming topic: %s", TopicTimelineItem)

	for {
		select {
		case <-ctx.Done():
			return
		default:
		}

		m, err := r.ReadMessage(ctx)
		if err != nil {
			log.Printf("failed to read message: %v", err)
			continue
		}

		// Unmarshal the message into Event struct
		var event messaging.TimelineEvent
		if err := json.Unmarshal(m.Value, &event); err != nil {
			log.Printf("failed to unmarshal message: %v", err)
			continue
		}

		if err := dispatch(ctx, u, event); err != nil {
			log.Printf("failed to process event %s: %v", event.Type, err)
		}
	}
}

// dispatch routes the event to the appropriate usecase method
func dispatch(ctx context.Context, u api.TimelineUsecase, e messaging.TimelineEvent) error {
	if len(e.Payload) == 0 {
		return fmt.Errorf("invalid payload: payload is empty")
	}

	switch e.Type {
	case messaging.TypeDeletePost:
		var input messaging.DeletePostMessage
		if err := json.Unmarshal(e.Payload, &input); err != nil {
			return fmt.Errorf("failed to unmarshal payload to DeletePostMessage: %w", err)
		}

		if err := input.Validate(); err != nil {
			return fmt.Errorf("validation failed: %w", err)
		}

		return u.DeletePost(ctx, input)
	default:
		return fmt.Errorf("unknown event type: %s", e.Type)
	}
}
