// Code generated by goa v3.15.2, DO NOT EDIT.
//
// notification HTTP client CLI support package
//
// Command:
// $ goa gen notification/design

package client

import (
	"encoding/json"
	"fmt"
	notification "notification/gen/notification"
)

// BuildCreateTweetNotificationPayload builds the payload for the notification
// CreateTweetNotification endpoint from CLI flags.
func BuildCreateTweetNotificationPayload(notificationCreateTweetNotificationBody string) (*notification.CreateTweetNotificationPayload, error) {
	var err error
	var body CreateTweetNotificationRequestBody
	{
		err = json.Unmarshal([]byte(notificationCreateTweetNotificationBody), &body)
		if err != nil {
			return nil, fmt.Errorf("invalid JSON for body, \nerror: %s, \nexample of valid JSON:\n%s", err, "'{\n      \"text\": \"Sint id soluta quos animi architecto libero.\",\n      \"tweet_id\": \"Itaque et magni accusantium fugit voluptatem.\"\n   }'")
		}
	}
	v := &notification.CreateTweetNotificationPayload{
		TweetID: body.TweetID,
		Text:    body.Text,
	}

	return v, nil
}