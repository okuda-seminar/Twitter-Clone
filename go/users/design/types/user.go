package types

import . "goa.design/goa/v3/dsl"

var User = Type("User", func() {
	Attribute("user_id", Int)
	Attribute("username", String)
	Attribute("bio", String)
	Attribute("created_at", String, func() {
		Format(FormatDateTime)
	})
	Attribute("updated_at", String, func() {
		Format(FormatDateTime)
	})

	Required("user_id", "username", "bio", "created_at", "updated_at")
})
