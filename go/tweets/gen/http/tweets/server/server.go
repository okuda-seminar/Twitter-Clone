// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets HTTP server
//
// Command:
// $ goa gen tweets/design

package server

import (
	"context"
	"net/http"
	tweets "tweets/gen/tweets"

	goahttp "goa.design/goa/v3/http"
)

// Server lists the tweets service endpoint HTTP handlers.
type Server struct {
	Mounts             []*MountPoint
	GenHTTPOpenapiJSON http.Handler
}

// MountPoint holds information about the mounted endpoints.
type MountPoint struct {
	// Method is the name of the service method served by the mounted HTTP handler.
	Method string
	// Verb is the HTTP method used to match requests to the mounted handler.
	Verb string
	// Pattern is the HTTP request path pattern used to match requests to the
	// mounted handler.
	Pattern string
}

// New instantiates HTTP handlers for all the tweets service endpoints using
// the provided encoder and decoder. The handlers are mounted on the given mux
// using the HTTP verb and path defined in the design. errhandler is called
// whenever a response fails to be encoded. formatter is used to format errors
// returned by the service methods prior to encoding. Both errhandler and
// formatter are optional and can be nil.
func New(
	e *tweets.Endpoints,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
	fileSystemGenHTTPOpenapiJSON http.FileSystem,
) *Server {
	if fileSystemGenHTTPOpenapiJSON == nil {
		fileSystemGenHTTPOpenapiJSON = http.Dir(".")
	}
	return &Server{
		Mounts: []*MountPoint{
			{"./gen/http/openapi.json", "GET", "/swagger.json"},
		},
		GenHTTPOpenapiJSON: http.FileServer(fileSystemGenHTTPOpenapiJSON),
	}
}

// Service returns the name of the service served.
func (s *Server) Service() string { return "tweets" }

// Use wraps the server handlers with the given middleware.
func (s *Server) Use(m func(http.Handler) http.Handler) {
}

// MethodNames returns the methods served.
func (s *Server) MethodNames() []string { return tweets.MethodNames[:] }

// Mount configures the mux to serve the tweets endpoints.
func Mount(mux goahttp.Muxer, h *Server) {
	MountGenHTTPOpenapiJSON(mux, goahttp.Replace("", "/./gen/http/openapi.json", h.GenHTTPOpenapiJSON))
}

// Mount configures the mux to serve the tweets endpoints.
func (s *Server) Mount(mux goahttp.Muxer) {
	Mount(mux, s)
}

// MountGenHTTPOpenapiJSON configures the mux to serve GET request made to
// "/swagger.json".
func MountGenHTTPOpenapiJSON(mux goahttp.Muxer, h http.Handler) {
	mux.Handle("GET", "/swagger.json", h.ServeHTTP)
}