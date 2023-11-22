package design

import . "goa.design/goa/v3/dsl"

var _ = API("profile", func() {
	Title("Profile Service")
	Description("Service for managing users' profile")
	Server("profile", func() {
		Host("localhost", func() {
			URI("http://localhost:80/api/profile")
			URI("grpc://localhost:8080")
		})
	})
})

var _ = Service("profile", func() {
	Description("The profile service performs operations on users' profile.")

	Method("FindByID", func() {
		Payload(func() {
			Field(1, "id", Int)
			Required("id")
		})

		Result(User)

		HTTP(func() {
			GET("/api/profile/{id}")
		})
	})

	Files("/swagger.json", "./gen/http/openapi.json")
})

var User = Type("User", func() {
	Attribute("username", String)
	Attribute("bio", String)

	Required("username")
	Required("bio")
})
