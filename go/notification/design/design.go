package design

import . "goa.design/goa/v3/dsl"

var _ = API("notification", func() {
	Title("Notification Service")
	Description("Service for managing notification")
	Server("notification", func() {
		Host("localhost", func() {
			URI("http://0.0.0.0:80/api/notification")
		})
	})
})

var _ = Service("notification", func() {
	Description("The notification service performs operations on notification information.")

	Error("BadRequest")

	Method("CreateTweetNotification", func() {
		Payload(func() {
			Field(1, "tweet_id", String)
			Field(2, "text", String)
			Required("tweet_id", "text")
		})
		Result(Empty)

		HTTP(func() {
			POST("/api/notification")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})
	Files("/swagger.json", "./gen/http/openapi.json")
})
