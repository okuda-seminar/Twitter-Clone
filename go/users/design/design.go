package design

import (
	"users/design/types"

	. "goa.design/goa/v3/dsl"
)

var _ = API("users", func() {
	Title("Users Service")
	Description("Service for managing users")
	Server("users", func() {
		Host("localhost", func() {
			URI("http://0.0.0.0:80/api/users")
		})
	})
})

var _ = Service("users", func() {
	Description("The users service performs operations on users information.")

	Error("NotFound")
	Error("BadRequest")

	Method("CreateUser", func() {
		Payload(func() {
			Field(1, "username", String)
			Field(2, "display_name", String)
			Required("username", "display_name")
		})
		Result(types.User)

		HTTP(func() {
			POST("/api/users")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("DeleteUser", func() {
		Payload(func() {
			Field(1, "id", Int)
			Required("id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/users")
			Response(StatusOK)
			Response("NotFound", StatusNotFound)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("FindUserByID", func() {
		Payload(func() {
			Field(1, "id", Int)
			Required("id")
		})
		Result(types.User)

		HTTP(func() {
			GET("/api/users/{id}")
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
			POST("/api/users/{id}/username")
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
			POST("/api/users/{id}/bio")
			Response(StatusOK)
			Response("NotFound", StatusNotFound)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Files("/swagger.json", "./gen/http/openapi.json")
})
