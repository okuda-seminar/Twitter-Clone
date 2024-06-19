package design

import . "goa.design/goa/v3/dsl"

var _ = API("notifications", func() {
	Title("Notifications Service")
	Description("Service for managing notifications")
	Server("notifications", func() {
		Host("localhost", func() {
			URI("http://0.0.0.0:80/api/notifications")
		})
	})
})

var _ = Service("notifications", func() {
	Description("The notifications service performs operations on notifications information.")

	Error("BadRequest")

	Method("CreateTweetNotification", func() {
		Payload(func() {
			Field(1, "tweet_id", String)
			Field(2, "text", String)
			Required("tweet_id", "text")
		})
		Result(Empty)

		HTTP(func() {
			POST("/api/notifications")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})
	Files("/swagger.json", "./gen/http/openapi.json")
})
