package cache

import (
	"context"

	"github.com/redis/go-redis/v9"
)

type CacheTimelineItemsRepository struct {
	client *redis.Client
}

func NewcacheTimelineItemsRepository(client *redis.Client) CacheTimelineItemsRepository {
	return CacheTimelineItemsRepository{
		client: client,
	}
}

func (c *CacheTimelineItemsRepository) CreatePost(postID string, usersID []string) error {
	ctx := context.Background()
	_, err := c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
		for _, userID := range usersID {
			p.RPush(ctx, userID, postID)
		}
		return nil
	})

	return err
}
