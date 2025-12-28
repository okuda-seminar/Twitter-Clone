package config

import (
	"os"

	"github.com/segmentio/kafka-go"
)

func OpenKafkaWriter(topic string) *kafka.Writer {
	// Implementation to open and return a KafkaWriter
	return &kafka.Writer{
		Addr:                   kafka.TCP(os.Getenv("KAFKA_BROKER_ADDR")),
		Topic:                  topic,
		Balancer:               &kafka.LeastBytes{},
		AllowAutoTopicCreation: true,
	}
}

func OpenKafkaReader(topic, groupID string) *kafka.Reader {
	return kafka.NewReader(kafka.ReaderConfig{
		Brokers: []string{os.Getenv("KAFKA_BROKER_ADDR")},
		Topic:   topic,
		GroupID: groupID,
	})
}
