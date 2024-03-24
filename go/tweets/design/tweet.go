package design

import . "goa.design/goa/v3/dsl"

var Tweet = Type("Tweet", func() {
	Attribute("id", Int)
	Attribute("user_id", Int)
	Attribute("text", String)
	Attribute("created_at", String, func() {
		Format(FormatDateTime)
	})

	Required("id", "user_id", "text", "created_at")
})
