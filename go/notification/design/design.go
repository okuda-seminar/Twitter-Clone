package design

import . "goa.design/goa/v3/dsl"

var _ = API("notification", func() {
	Title("Tweets Service")
	Description("Service for managing notification")
	Server("notification", func() {
		Host("localhost", func() {
			URI("http://0.0.0.0:80/api/notification")
		})
	})
})

var _ = Service("notification", func() {
	Description("The notification service performs operations on notification information.")

	Files("/swagger.json", "./gen/http/openapi.json")
})
