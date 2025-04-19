package controller

import (
	"database/sql"
	"sync"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/controller/handler"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/openapi"
)

var _ openapi.ServerInterface = (*Server)(nil)

// [Server] satisfies [ServerInterface] defined in gen/server.gen.go.
type Server struct {
	handler.CreateUserHandler
	handler.LoginHandler
	handler.FindUserByIDHandler
	handler.CreatePostHandler
	handler.CreateRepostHandler
	handler.CreateQuoteRepostHandler
	handler.DeleteRepostHandler
	handler.GetUserPostsTimelineHandler
	handler.GetReverseChronologicalHomeTimelineHandler
	handler.CreateFollowshipHandler
	handler.DeleteUserHandler
}

func NewServer(db *sql.DB, mu *sync.Mutex, usersChan *map[string]chan entity.TimelineEvent, authService *service.AuthService) Server {
	return Server{
		CreateUserHandler:                          handler.NewCreateUserHandler(db, authService),
		LoginHandler:                               handler.NewLoginHandler(db, authService),
		FindUserByIDHandler:                        handler.NewFindUserByIDHandler(db),
		CreatePostHandler:                          handler.NewCreatePostHandler(db, mu, usersChan),
		CreateRepostHandler:                        handler.NewCreateRepostHandler(db, mu, usersChan),
		CreateQuoteRepostHandler:                   handler.NewCreateQuoteRepostHandler(db, mu, usersChan),
		DeleteRepostHandler:                        handler.NewDeleteRepostHandler(db, mu, usersChan),
		GetUserPostsTimelineHandler:                handler.NewGetUserPostsTimelineHandler(db),
		GetReverseChronologicalHomeTimelineHandler: handler.NewGetReverseChronologicalHomeTimelineHandler(db, mu, usersChan, make(chan struct{}, 1)),
		CreateFollowshipHandler:                    handler.NewCreateFollowshipHandler(db),
		DeleteUserHandler:                          handler.NewDeleteUserHandler(service.NewDeleteUserUsecase(db)),
	}
}
