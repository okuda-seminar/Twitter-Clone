package design

import (
	"tweets/design/types"

	. "goa.design/goa/v3/dsl"
)

var _ = API("tweets", func() {
	Title("Tweets Service")
	Description("Service for managing tweets")
	Server("tweets", func() {
		Host("localhost", func() {
			URI("http://0.0.0.0:80/api/tweets")
		})
	})
})

var _ = Service("tweets", func() {
	Description("The tweets service performs operations on tweets information.")

	Error("NotFound")
	Error("BadRequest")

	Method("CreateTweet", func() {
		Payload(func() {
			Field(1, "user_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "text", String)
			Required("user_id", "text")
		})
		Result(types.Tweet)

		HTTP(func() {
			POST("/api/tweets")

			Response(StatusOK, func() {
				Description("Created tweet")
			})
			Response("NotFound", StatusNotFound, func() {
				Description("User was not found")
			})
			Response("BadRequest", StatusBadRequest, func() {
				Description("Failed to create tweet")
			})
		})
	})

	Method("DeleteTweet", func() {
		Payload(func() {
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
			Required("id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/tweets")
			Response(StatusOK)
			Response("NotFound", StatusNotFound)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("LikeTweet", func() {
		Payload(func() {
			Field(1, "tweet_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "user_id", String, func() {
				Format(FormatUUID)
			})
			Required("tweet_id", "user_id")
		})
		Result(Empty)

		HTTP(func() {
			POST("/api/tweets/like")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("DeleteTweetLike", func() {
		Payload(func() {
			Field(1, "tweet_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "user_id", String, func() {
				Format(FormatUUID)
			})
			Required("tweet_id", "user_id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/tweets/like")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("Retweet", func() {
		Payload(func() {
			Field(1, "tweet_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "user_id", String, func() {
				Format(FormatUUID)
			})
			Required("tweet_id", "user_id")
		})
		Result(Empty)

		HTTP(func() {
			POST("/api/tweets/retweet")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("DeleteRetweet", func() {
		Payload(func() {
			Field(1, "tweet_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "user_id", String, func() {
				Format(FormatUUID)
			})
			Required("tweet_id", "user_id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/tweets/retweet")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("CreateReply", func() {
		Payload(func() {
			Field(1, "tweet_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "user_id", String, func() {
				Format(FormatUUID)
			})
			Field(3, "text", String)
			Required("tweet_id", "user_id", "text")
		})
		Result(types.Reply)

		HTTP(func() {
			POST("/api/tweets/reply")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("DeleteReply", func() {
		Payload(func() {
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
			Required("id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/tweets/reply")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Files("/swagger.json", "./gen/http/openapi.json")
})
