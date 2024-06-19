package types

import . "goa.design/goa/v3/dsl"

var User = Type("User", func() {
	Attribute("id", String, func() {
		Format(FormatUUID)
	})
	Attribute("username", String)
	Attribute("display_name", String)
	Attribute("bio", String)
	Attribute("created_at", String, func() {
		Format(FormatDateTime)
	})
	Attribute("updated_at", String, func() {
		Format(FormatDateTime)
	})
	Attribute("is_private", Boolean)

	Required("id", "username", "display_name", "bio", "created_at", "updated_at", "is_private")
})
