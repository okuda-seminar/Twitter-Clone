package cache

import (
	"context"
	"fmt"
	"log"

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

func (c *CacheTimelineItemsRepository) CreatePost(postID string, userIDs []string, timestamp float64) error {
	ctx := context.Background()
	_, err := c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
		for _, userID := range userIDs {
			p.ZAdd(ctx, fmt.Sprintf("timeline:%s", userID), redis.Z{Score: timestamp, Member: postID})
		}
		return nil
	})
	if err != nil {
		_, err := c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
			for _, userID := range userIDs {
				p.ZRem(ctx, fmt.Sprintf("timeline:%s", userID), postID)
			}
			return nil
		})
		if err != nil {
			log.Println("Failed to rollback cache after CreatePost error:", err)
			log.Println("The following users' timelines are inconsistent", userIDs)
			return err
		}
	}

	return err
}
