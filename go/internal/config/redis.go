package config

import (
	"os"

	"github.com/redis/go-redis/v9"
)

func RedisClient() *redis.Client {
	client := redis.NewClient(&redis.Options{
		Addr:     os.Getenv("REDIS_ADDR"),
		Password: os.Getenv("REDIS_PASSWORD"),
		DB:       0, // Use default DB
	})

	return client
}
