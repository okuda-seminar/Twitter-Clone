package cache

import (
	"github.com/redis/go-redis/v9"
)

type cacheTimelineItemsRepository struct {
	client *redis.Client
}

func NewcacheTimelineItemsRepository(client *redis.Client) CacheTimelineItemsRepository {
	return cacheTimelineItemsRepository{
		client: client,
	}
}
