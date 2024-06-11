// Code generated by goa v3.14.0, DO NOT EDIT.
//
// users HTTP server
//
// Command:
// $ goa gen users/design

package server

import (
	"context"
	"net/http"
	users "users/gen/users"

	goahttp "goa.design/goa/v3/http"
	goa "goa.design/goa/v3/pkg"
)

// Server lists the users service endpoint HTTP handlers.
type Server struct {
	Mounts             []*MountPoint
	CreateUser         http.Handler
	DeleteUser         http.Handler
	FindUserByID       http.Handler
	UpdateUsername     http.Handler
	UpdateBio          http.Handler
	Follow             http.Handler
	Unfollow           http.Handler
	GetFollowers       http.Handler
	GetFollowings      http.Handler
	Mute               http.Handler
	Unmute             http.Handler
	Block              http.Handler
	Unblock            http.Handler
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

// New instantiates HTTP handlers for all the users service endpoints using the
// provided encoder and decoder. The handlers are mounted on the given mux
// using the HTTP verb and path defined in the design. errhandler is called
// whenever a response fails to be encoded. formatter is used to format errors
// returned by the service methods prior to encoding. Both errhandler and
// formatter are optional and can be nil.
func New(
	e *users.Endpoints,
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
			{"CreateUser", "POST", "/api/users"},
			{"DeleteUser", "DELETE", "/api/users/{id}"},
			{"FindUserByID", "GET", "/api/users/{id}"},
			{"UpdateUsername", "POST", "/api/users/{id}/username"},
			{"UpdateBio", "POST", "/api/users/{id}/bio"},
			{"Follow", "POST", "/api/users/{following_user_id}/follow"},
			{"Unfollow", "DELETE", "/api/users/{following_user_id}/follow/{followed_user_id}"},
			{"GetFollowers", "GET", "/api/users/{id}/followers"},
			{"GetFollowings", "GET", "/api/users/{id}/followings"},
			{"Mute", "POST", "/api/users/{muting_user_id}/mute"},
			{"Unmute", "DELETE", "/api/users/{muting_user_id}/mute/{muted_user_id}"},
			{"Block", "POST", "/api/users/{blocking_user_id}/block"},
			{"Unblock", "DELETE", "/api/users/{blocking_user_id}/block/{blocked_user_id}"},
			{"./gen/http/openapi.json", "GET", "/swagger.json"},
		},
		CreateUser:         NewCreateUserHandler(e.CreateUser, mux, decoder, encoder, errhandler, formatter),
		DeleteUser:         NewDeleteUserHandler(e.DeleteUser, mux, decoder, encoder, errhandler, formatter),
		FindUserByID:       NewFindUserByIDHandler(e.FindUserByID, mux, decoder, encoder, errhandler, formatter),
		UpdateUsername:     NewUpdateUsernameHandler(e.UpdateUsername, mux, decoder, encoder, errhandler, formatter),
		UpdateBio:          NewUpdateBioHandler(e.UpdateBio, mux, decoder, encoder, errhandler, formatter),
		Follow:             NewFollowHandler(e.Follow, mux, decoder, encoder, errhandler, formatter),
		Unfollow:           NewUnfollowHandler(e.Unfollow, mux, decoder, encoder, errhandler, formatter),
		GetFollowers:       NewGetFollowersHandler(e.GetFollowers, mux, decoder, encoder, errhandler, formatter),
		GetFollowings:      NewGetFollowingsHandler(e.GetFollowings, mux, decoder, encoder, errhandler, formatter),
		Mute:               NewMuteHandler(e.Mute, mux, decoder, encoder, errhandler, formatter),
		Unmute:             NewUnmuteHandler(e.Unmute, mux, decoder, encoder, errhandler, formatter),
		Block:              NewBlockHandler(e.Block, mux, decoder, encoder, errhandler, formatter),
		Unblock:            NewUnblockHandler(e.Unblock, mux, decoder, encoder, errhandler, formatter),
		GenHTTPOpenapiJSON: http.FileServer(fileSystemGenHTTPOpenapiJSON),
	}
}

// Service returns the name of the service served.
func (s *Server) Service() string { return "users" }

// Use wraps the server handlers with the given middleware.
func (s *Server) Use(m func(http.Handler) http.Handler) {
	s.CreateUser = m(s.CreateUser)
	s.DeleteUser = m(s.DeleteUser)
	s.FindUserByID = m(s.FindUserByID)
	s.UpdateUsername = m(s.UpdateUsername)
	s.UpdateBio = m(s.UpdateBio)
	s.Follow = m(s.Follow)
	s.Unfollow = m(s.Unfollow)
	s.GetFollowers = m(s.GetFollowers)
	s.GetFollowings = m(s.GetFollowings)
	s.Mute = m(s.Mute)
	s.Unmute = m(s.Unmute)
	s.Block = m(s.Block)
	s.Unblock = m(s.Unblock)
}

// MethodNames returns the methods served.
func (s *Server) MethodNames() []string { return users.MethodNames[:] }

// Mount configures the mux to serve the users endpoints.
func Mount(mux goahttp.Muxer, h *Server) {
	MountCreateUserHandler(mux, h.CreateUser)
	MountDeleteUserHandler(mux, h.DeleteUser)
	MountFindUserByIDHandler(mux, h.FindUserByID)
	MountUpdateUsernameHandler(mux, h.UpdateUsername)
	MountUpdateBioHandler(mux, h.UpdateBio)
	MountFollowHandler(mux, h.Follow)
	MountUnfollowHandler(mux, h.Unfollow)
	MountGetFollowersHandler(mux, h.GetFollowers)
	MountGetFollowingsHandler(mux, h.GetFollowings)
	MountMuteHandler(mux, h.Mute)
	MountUnmuteHandler(mux, h.Unmute)
	MountBlockHandler(mux, h.Block)
	MountUnblockHandler(mux, h.Unblock)
	MountGenHTTPOpenapiJSON(mux, goahttp.Replace("", "/./gen/http/openapi.json", h.GenHTTPOpenapiJSON))
}

// Mount configures the mux to serve the users endpoints.
func (s *Server) Mount(mux goahttp.Muxer) {
	Mount(mux, s)
}

// MountCreateUserHandler configures the mux to serve the "users" service
// "CreateUser" endpoint.
func MountCreateUserHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("POST", "/api/users", f)
}

// NewCreateUserHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "CreateUser" endpoint.
func NewCreateUserHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeCreateUserRequest(mux, decoder)
		encodeResponse = EncodeCreateUserResponse(encoder)
		encodeError    = EncodeCreateUserError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "CreateUser")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountDeleteUserHandler configures the mux to serve the "users" service
// "DeleteUser" endpoint.
func MountDeleteUserHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("DELETE", "/api/users/{id}", f)
}

// NewDeleteUserHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "DeleteUser" endpoint.
func NewDeleteUserHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeDeleteUserRequest(mux, decoder)
		encodeResponse = EncodeDeleteUserResponse(encoder)
		encodeError    = EncodeDeleteUserError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "DeleteUser")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountFindUserByIDHandler configures the mux to serve the "users" service
// "FindUserByID" endpoint.
func MountFindUserByIDHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("GET", "/api/users/{id}", f)
}

// NewFindUserByIDHandler creates a HTTP handler which loads the HTTP request
// and calls the "users" service "FindUserByID" endpoint.
func NewFindUserByIDHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeFindUserByIDRequest(mux, decoder)
		encodeResponse = EncodeFindUserByIDResponse(encoder)
		encodeError    = EncodeFindUserByIDError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "FindUserByID")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountUpdateUsernameHandler configures the mux to serve the "users" service
// "UpdateUsername" endpoint.
func MountUpdateUsernameHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("POST", "/api/users/{id}/username", f)
}

// NewUpdateUsernameHandler creates a HTTP handler which loads the HTTP request
// and calls the "users" service "UpdateUsername" endpoint.
func NewUpdateUsernameHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeUpdateUsernameRequest(mux, decoder)
		encodeResponse = EncodeUpdateUsernameResponse(encoder)
		encodeError    = EncodeUpdateUsernameError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "UpdateUsername")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountUpdateBioHandler configures the mux to serve the "users" service
// "UpdateBio" endpoint.
func MountUpdateBioHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("POST", "/api/users/{id}/bio", f)
}

// NewUpdateBioHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "UpdateBio" endpoint.
func NewUpdateBioHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeUpdateBioRequest(mux, decoder)
		encodeResponse = EncodeUpdateBioResponse(encoder)
		encodeError    = EncodeUpdateBioError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "UpdateBio")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountFollowHandler configures the mux to serve the "users" service "Follow"
// endpoint.
func MountFollowHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("POST", "/api/users/{following_user_id}/follow", f)
}

// NewFollowHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "Follow" endpoint.
func NewFollowHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeFollowRequest(mux, decoder)
		encodeResponse = EncodeFollowResponse(encoder)
		encodeError    = EncodeFollowError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "Follow")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountUnfollowHandler configures the mux to serve the "users" service
// "Unfollow" endpoint.
func MountUnfollowHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("DELETE", "/api/users/{following_user_id}/follow/{followed_user_id}", f)
}

// NewUnfollowHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "Unfollow" endpoint.
func NewUnfollowHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeUnfollowRequest(mux, decoder)
		encodeResponse = EncodeUnfollowResponse(encoder)
		encodeError    = EncodeUnfollowError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "Unfollow")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountGetFollowersHandler configures the mux to serve the "users" service
// "GetFollowers" endpoint.
func MountGetFollowersHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("GET", "/api/users/{id}/followers", f)
}

// NewGetFollowersHandler creates a HTTP handler which loads the HTTP request
// and calls the "users" service "GetFollowers" endpoint.
func NewGetFollowersHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeGetFollowersRequest(mux, decoder)
		encodeResponse = EncodeGetFollowersResponse(encoder)
		encodeError    = EncodeGetFollowersError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "GetFollowers")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountGetFollowingsHandler configures the mux to serve the "users" service
// "GetFollowings" endpoint.
func MountGetFollowingsHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("GET", "/api/users/{id}/followings", f)
}

// NewGetFollowingsHandler creates a HTTP handler which loads the HTTP request
// and calls the "users" service "GetFollowings" endpoint.
func NewGetFollowingsHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeGetFollowingsRequest(mux, decoder)
		encodeResponse = EncodeGetFollowingsResponse(encoder)
		encodeError    = EncodeGetFollowingsError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "GetFollowings")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountMuteHandler configures the mux to serve the "users" service "Mute"
// endpoint.
func MountMuteHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("POST", "/api/users/{muting_user_id}/mute", f)
}

// NewMuteHandler creates a HTTP handler which loads the HTTP request and calls
// the "users" service "Mute" endpoint.
func NewMuteHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeMuteRequest(mux, decoder)
		encodeResponse = EncodeMuteResponse(encoder)
		encodeError    = EncodeMuteError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "Mute")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountUnmuteHandler configures the mux to serve the "users" service "Unmute"
// endpoint.
func MountUnmuteHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("DELETE", "/api/users/{muting_user_id}/mute/{muted_user_id}", f)
}

// NewUnmuteHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "Unmute" endpoint.
func NewUnmuteHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeUnmuteRequest(mux, decoder)
		encodeResponse = EncodeUnmuteResponse(encoder)
		encodeError    = EncodeUnmuteError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "Unmute")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountBlockHandler configures the mux to serve the "users" service "Block"
// endpoint.
func MountBlockHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("POST", "/api/users/{blocking_user_id}/block", f)
}

// NewBlockHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "Block" endpoint.
func NewBlockHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeBlockRequest(mux, decoder)
		encodeResponse = EncodeBlockResponse(encoder)
		encodeError    = EncodeBlockError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "Block")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountUnblockHandler configures the mux to serve the "users" service
// "Unblock" endpoint.
func MountUnblockHandler(mux goahttp.Muxer, h http.Handler) {
	f, ok := h.(http.HandlerFunc)
	if !ok {
		f = func(w http.ResponseWriter, r *http.Request) {
			h.ServeHTTP(w, r)
		}
	}
	mux.Handle("DELETE", "/api/users/{blocking_user_id}/block/{blocked_user_id}", f)
}

// NewUnblockHandler creates a HTTP handler which loads the HTTP request and
// calls the "users" service "Unblock" endpoint.
func NewUnblockHandler(
	endpoint goa.Endpoint,
	mux goahttp.Muxer,
	decoder func(*http.Request) goahttp.Decoder,
	encoder func(context.Context, http.ResponseWriter) goahttp.Encoder,
	errhandler func(context.Context, http.ResponseWriter, error),
	formatter func(ctx context.Context, err error) goahttp.Statuser,
) http.Handler {
	var (
		decodeRequest  = DecodeUnblockRequest(mux, decoder)
		encodeResponse = EncodeUnblockResponse(encoder)
		encodeError    = EncodeUnblockError(encoder, formatter)
	)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := context.WithValue(r.Context(), goahttp.AcceptTypeKey, r.Header.Get("Accept"))
		ctx = context.WithValue(ctx, goa.MethodKey, "Unblock")
		ctx = context.WithValue(ctx, goa.ServiceKey, "users")
		payload, err := decodeRequest(r)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		res, err := endpoint(ctx, payload)
		if err != nil {
			if err := encodeError(ctx, w, err); err != nil {
				errhandler(ctx, w, err)
			}
			return
		}
		if err := encodeResponse(ctx, w, res); err != nil {
			errhandler(ctx, w, err)
		}
	})
}

// MountGenHTTPOpenapiJSON configures the mux to serve GET request made to
// "/swagger.json".
func MountGenHTTPOpenapiJSON(mux goahttp.Muxer, h http.Handler) {
	mux.Handle("GET", "/swagger.json", h.ServeHTTP)
}
