package design

import . "goa.design/goa/v3/dsl"

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
			Field(1, "user_id", Int)
			Field(2, "text", String)
			Required("user_id", "text")
		})
		Result(Tweet)

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

	Files("/swagger.json", "./gen/http/openapi.json")
})
