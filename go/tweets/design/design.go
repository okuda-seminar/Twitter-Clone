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

	Files("/swagger.json", "./gen/http/openapi.json")
})
