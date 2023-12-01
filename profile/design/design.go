package design

import . "goa.design/goa/v3/dsl"

var _ = API("profile", func() {
	Title("Profile Service")
	Description("Service for managing users' profile")
	Server("profile", func() {
		Host("localhost", func() {
			URI("http://0.0.0.0:80/api/profile")
			URI("grpc://localhost:8080")
		})
	})
})

var _ = Service("profile", func() {
	Description("The profile service performs operations on users' profile.")

	Error("NotFound")
	Error("BadRequest")

	Method("FindByID", func() {
		Payload(func() {
			Field(1, "id", Int)
			Required("id")
		})
		Result(User)

		HTTP(func() {
			GET("/api/profile/{id}")
			Response(StatusOK)
			Response("NotFound", StatusNotFound)
		})
	})

	Method("UpdateUsername", func() {
		Payload(func() {
			Field(1, "id", Int)
			Field(2, "username", String)
			Required("id", "username")
		})
		Result(Empty)
		HTTP(func() {
			POST("/api/profile/{id}/edit/username")
			Response(StatusOK)
			Response("NotFound", StatusNotFound)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("UpdateBio", func() {
		Payload(func() {
			Field(1, "id", Int)
			Field(2, "bio", String)
			Required("id", "bio")
		})
		Result(Empty)
		HTTP(func() {
			POST("/api/profile/edit/bio")
			Response(StatusOK)
			Response("NotFound", StatusNotFound)
			Response("BadRequest", StatusBadRequest)
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
