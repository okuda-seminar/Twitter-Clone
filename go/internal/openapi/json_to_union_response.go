package openapi

import "encoding/json"

func JsonToGetPostByPostIdResponse(union json.RawMessage) *GetPostByPostIdResponse {
	return &GetPostByPostIdResponse{
		union: union,
	}
}

func JsonToParentPost(union json.RawMessage) *ParentPost {
	return &ParentPost{
		union: union,
	}
}
