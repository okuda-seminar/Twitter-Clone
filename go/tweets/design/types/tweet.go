package types

import . "goa.design/goa/v3/dsl"

var Tweet = Type("Tweet", func() {
	Attribute("id", String, func() {
		Format(FormatUUID)
	})
	Attribute("user_id", String, func() {
		Format(FormatUUID)
	})
	Attribute("text", String)
	Attribute("created_at", String, func() {
		Format(FormatDateTime)
	})

	Required("id", "user_id", "text", "created_at")
})

var Reply = Type("Reply", func() {
	Attribute("id", String, func() {
		Format(FormatUUID)
	})
	Attribute("tweet_id", String, func() {
		Format(FormatUUID)
	})
	Attribute("user_id", String, func() {
		Format(FormatUUID)
	})
	Attribute("text", String)
	Attribute("created_at", String, func() {
		Format(FormatDateTime)
	})

	Required("id", "tweet_id", "user_id", "text", "created_at")
})
