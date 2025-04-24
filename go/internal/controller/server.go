package controller

import (
	"database/sql"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/controller/handler"
	"x-clone-backend/internal/openapi"
)

var _ openapi.ServerInterface = (*Server)(nil)

// [Server] satisfies [ServerInterface] defined in gen/server.gen.go.
type Server struct {
	handler.CreateUserHandler
	handler.LoginHandler
	handler.VerifySessionHandler
	handler.FindUserByIDHandler
	handler.CreatePostHandler
	handler.CreateRepostHandler
	handler.CreateQuoteRepostHandler
	handler.DeleteRepostHandler
	handler.GetUserPostsTimelineHandler
	handler.GetReverseChronologicalHomeTimelineHandler
	handler.CreateFollowshipHandler
}

func NewServer(db *sql.DB, authService *service.AuthService, updateNotificationUsecase usecase.UpdateNotificationUsecase) Server {
	return Server{
		CreateUserHandler:                          handler.NewCreateUserHandler(db, authService),
		LoginHandler:                               handler.NewLoginHandler(db, authService),
		VerifySessionHandler:                       handler.NewVerifySessionHandler(db, authService),
		FindUserByIDHandler:                        handler.NewFindUserByIDHandler(db),
		CreatePostHandler:                          handler.NewCreatePostHandler(db, updateNotificationUsecase),
		CreateRepostHandler:                        handler.NewCreateRepostHandler(db, updateNotificationUsecase),
		CreateQuoteRepostHandler:                   handler.NewCreateQuoteRepostHandler(db, updateNotificationUsecase),
		DeleteRepostHandler:                        handler.NewDeleteRepostHandler(db, updateNotificationUsecase),
		GetUserPostsTimelineHandler:                handler.NewGetUserPostsTimelineHandler(db),
		GetReverseChronologicalHomeTimelineHandler: handler.NewGetReverseChronologicalHomeTimelineHandler(db, updateNotificationUsecase, make(chan struct{}, 1)),
		CreateFollowshipHandler:                    handler.NewCreateFollowshipHandler(db),
	}
}
