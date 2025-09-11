package cache

import (
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
