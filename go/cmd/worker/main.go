package main

import (
	"context"
	"log"
	"os"
	"os/signal"
	"syscall"

	"x-clone-backend/internal/config"
	"x-clone-backend/internal/infrastructure/cache"
	"x-clone-backend/internal/worker/handler"
	usecase "x-clone-backend/internal/worker/usecase/implementation"
)

func main() {
	redisClient := config.RedisClient()
	defer redisClient.Close()
	timelineRepo := cache.NewcacheTimelineItemsRepository(redisClient)
	timelineUsecase := usecase.NewTimelineUsecase(timelineRepo)
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// create a goroutine to consume each topic
	go handler.ConsumeTimelineItems(ctx, timelineUsecase)

	// graceful shutdown
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)
	<-sigChan
	log.Println("Shutting down worker...")
}
