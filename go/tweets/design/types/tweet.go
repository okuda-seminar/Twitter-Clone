package types

import . "goa.design/goa/v3/dsl"

var Tweet = Type("Tweet", func() {
	Attribute("id", String)
	Attribute("user_id", String)
	Attribute("text", String)
	Attribute("created_at", String, func() {
		Format(FormatDateTime)
	})

	Required("id", "user_id", "text", "created_at")
})
