package messaging

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"x-clone-backend/internal/domain/messaging"

	"github.com/segmentio/kafka-go"
)

type KafkaTimelineItemEventProducer struct {
	writer *kafka.Writer
}

func NewKafkaTimelineItemEventProducer(w *kafka.Writer) *KafkaTimelineItemEventProducer {
	return &KafkaTimelineItemEventProducer{
		writer: w,
	}
}

func (p *KafkaTimelineItemEventProducer) PublishDeleteTimelineItemEvent(ctx context.Context, msg messaging.DeletePostMessage) error {
	if err := msg.Validate(); err != nil {
		return fmt.Errorf("invalid DeleteTimelineItemMessage: %w", err)
	}

	return p.send(ctx, messaging.TypeDeletePost, msg)
}

func (p *KafkaTimelineItemEventProducer) PublishDeleteRepostEvent(ctx context.Context, msg messaging.DeleteRepostMessage) error {
	if err := msg.Validate(); err != nil {
		return fmt.Errorf("invalid DeletePostMessage: %w", err)
	}

	return p.send(ctx, messaging.TypeDeleteRepost, msg)
}

func (p *KafkaTimelineItemEventProducer) send(ctx context.Context, eventType string, payload any) error {
	payloadBytes, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("failed to marshal payload: %w", err)
	}
	evt := messaging.TimelineEvent{
		Type:    eventType,
		Payload: payloadBytes,
	}

	val, err := json.Marshal(evt)
	if err != nil {
		return fmt.Errorf("failed to marshal event: %w", err)
	}

	msg := kafka.Message{
		Value: val,
		Time:  time.Now(),
	}

	if err := p.writer.WriteMessages(ctx, msg); err != nil {
		return fmt.Errorf("failed to write kafka message: %w", err)
	}

	return nil
}
