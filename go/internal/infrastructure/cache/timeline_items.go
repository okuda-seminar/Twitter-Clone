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

// CreatePost inserts a new post to the given userIDs' timeline.
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

	// create reversed index
	_, err = c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
		for _, userID := range userIDs {
			p.SAdd(ctx, fmt.Sprintf("timelineitem:%s", postID), userID)
		}
		return nil
	})
	if err != nil {
		log.Printf("Failed to create reversed index. PostID: %s, UserIDs: %v, Error: %v", postID, userIDs, err)
	}

	return err
}

// CreateRepost inserts a new repost to the given userIDs' timeline.
func (c *CacheTimelineItemsRepository) CreateRepost(postID string, userIDs []string, timestamp float64) error {
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
			log.Println("Failed to rollback cache after CreateRepost error:", err)
			log.Println("The following users' timelines are inconsistent", userIDs)
			return err
		}
	}

	// create reversed index
	_, err = c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
		for _, userID := range userIDs {
			p.SAdd(ctx, fmt.Sprintf("timelineitem:%s", postID), userID)
		}
		return nil
	})
	if err != nil {
		log.Printf("Failed to create reversed index. PostID: %s, UserIDs: %v, Error: %v", postID, userIDs, err)
	}

	return err
}

// CreateQuoteRepost inserts a new quote repost to the given userIDs' timeline.
func (c *CacheTimelineItemsRepository) CreateQuoteRepost(postID string, userIDs []string, timestamp float64) error {
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
			log.Println("Failed to rollback cache after CreateQuoteRepost error:", err)
			log.Println("The following users' timelines are inconsistent", userIDs)
			return err
		}
	}

	// create reversed index
	_, err = c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
		for _, userID := range userIDs {
			p.SAdd(ctx, fmt.Sprintf("timelineitem:%s", postID), userID)
		}
		return nil
	})
	if err != nil {
		log.Printf("Failed to create reversed index. PostID: %s, UserIDs: %v, Error: %v", postID, userIDs, err)
	}

	return err
}

// UserAndFolloweePosts retrieves the post IDs from the timeline cache for the given user ID.
func (c *CacheTimelineItemsRepository) UserAndFolloweePosts(userID string) ([]string, error) {
	ctx := context.Background()
	key := fmt.Sprintf("timeline:%s", userID)
	postIDs, err := c.client.ZRevRange(ctx, key, 0, -1).Result()
	if err != nil {
		return nil, err
	}
	return postIDs, nil
}

// DeletePost removes a post from the timeline cache
func (c *CacheTimelineItemsRepository) DeletePost(postID string) error {
	ctx := context.Background()
	// since current user following could be different from when the post was created,
	// retrieve userIDs containing the postID to be deleted from the "timelineitem:postID" set
	userIDs, err := c.client.SMembers(ctx, fmt.Sprintf("timelineitem:%s", postID)).Result()
	if err != nil {
		return fmt.Errorf("Failed to fetch userIDs from reversed index: %s", postID)
	}

	_, err = c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
		for _, userID := range userIDs {
			p.ZRem(ctx, fmt.Sprintf("timeline:%s", userID), postID)
		}
		return nil
	})

	if err != nil {
		return fmt.Errorf("Failed to delete postID from some user timelines: %s", postID)
	}

	// In case of failure to delete the post ID from the user timeline,
	// delete the reversed index after all processing is complete.
	if err := c.client.Del(ctx, fmt.Sprintf("timelineitem:%s", postID)).Err(); err != nil {
		return fmt.Errorf("Failed to delete reversed index: %s", postID)
	}

	return nil
}

// DeleteRepost removes a repost from the timeline cache
func (c *CacheTimelineItemsRepository) DeleteRepost(postID string) error {
	ctx := context.Background()
	// since current user following could be different from when the repost was created,
	// retrieve userIDs containing the postID to be deleted from the "timelineitem:postID" set
	userIDs, err := c.client.SMembers(ctx, fmt.Sprintf("timelineitem:%s", postID)).Result()
	if err != nil {
		return fmt.Errorf("Failed to fetch userIDs from reversed index: %s", postID)
	}

	_, err = c.client.Pipelined(ctx, func(p redis.Pipeliner) error {
		for _, userID := range userIDs {
			p.ZRem(ctx, fmt.Sprintf("timeline:%s", userID), postID)
		}
		return nil
	})

	if err != nil {
		return fmt.Errorf("Failed to delete repostID from some user timelines: %s", postID)
	}

	// In case of failure to delete the repost ID from the user timeline,
	// delete the reversed index after all processing is complete.
	if err := c.client.Del(ctx, fmt.Sprintf("timelineitem:%s", postID)).Err(); err != nil {
		return fmt.Errorf("Failed to delete reversed index: %s", postID)
	}

	return nil
}
