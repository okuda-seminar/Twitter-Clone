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
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
			Required("id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/users/{id}")
			Response(StatusOK)
			Response("NotFound", StatusNotFound)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("FindUserByID", func() {
		Payload(func() {
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
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
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
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
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
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

	Method("Follow", func() {
		Payload(func() {
			Field(1, "following_user_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "followed_user_id", String, func() {
				Format(FormatUUID)
			})
			Required("following_user_id", "followed_user_id")
		})
		Result(Empty)

		HTTP(func() {
			POST("/api/users/{following_user_id}/follow")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("Unfollow", func() {
		Payload(func() {
			Field(1, "following_user_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "followed_user_id", String, func() {
				Format(FormatUUID)
			})
			Required("following_user_id", "followed_user_id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/users/{following_user_id}/follow/{followed_user_id}")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("GetFollowers", func() {
		Payload(func() {
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
			Required("id")
		})
		Result(ArrayOf(types.User))

		HTTP(func() {
			GET("/api/users/{id}/followers")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("GetFollowings", func() {
		Payload(func() {
			Field(1, "id", String, func() {
				Format(FormatUUID)
			})
			Required("id")
		})
		Result(ArrayOf(types.User))

		HTTP(func() {
			GET("/api/users/{id}/followings")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("Mute", func() {
		Payload(func() {
			Field(1, "muted_user_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "muting_user_id", String, func() {
				Format(FormatUUID)
			})
			Required("muted_user_id", "muting_user_id")
		})
		Result(Empty)

		HTTP(func() {
			POST("/api/users/{muting_user_id}/mute")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("Unmute", func() {
		Payload(func() {
			Field(1, "muted_user_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "muting_user_id", String, func() {
				Format(FormatUUID)
			})
			Required("muted_user_id", "muting_user_id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/users/{muting_user_id}/mute/{muted_user_id}")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("Block", func() {
		Payload(func() {
			Field(1, "blocked_user_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "blocking_user_id", String, func() {
				Format(FormatUUID)
			})
			Required("blocked_user_id", "blocking_user_id")
		})
		Result(Empty)

		HTTP(func() {
			POST("/api/users/{blocking_user_id}/block")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Method("Unblock", func() {
		Payload(func() {
			Field(1, "blocked_user_id", String, func() {
				Format(FormatUUID)
			})
			Field(2, "blocking_user_id", String, func() {
				Format(FormatUUID)
			})
			Required("blocked_user_id", "blocking_user_id")
		})
		Result(Empty)

		HTTP(func() {
			DELETE("/api/users/{blocking_user_id}/block/{blocked_user_id}")
			Response(StatusOK)
			Response("BadRequest", StatusBadRequest)
		})
	})

	Files("/swagger.json", "./gen/http/openapi.json")
})
