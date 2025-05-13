package controller

import (
	"database/sql"
	"os"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/controller/handler"
	"x-clone-backend/internal/infrastructure"
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

func NewServer(db *sql.DB) Server {
	timelineItemsRepository := infrastructure.InjectTimelineItemsRepository(db)
	usersRepository := infrastructure.InjectUsersRepository(db)

	secretKey := os.Getenv("SECRET_KEY")
	authService := service.NewAuthService(secretKey)

	createPostUsecase := interactor.NewCreatePostUsecase(timelineItemsRepository)
	loginUsecase := interactor.NewLoginUsecase(usersRepository, authService)
	updateNotificationUsecase := interactor.NewUpdateNotificationUsecase(usersRepository)
	userByUserIDUsecase := interactor.NewUserByUserIDUsecase(usersRepository)

	return Server{
		CreateUserHandler:                          handler.NewCreateUserHandler(db, authService),
		LoginHandler:                               handler.NewLoginHandler(loginUsecase),
		VerifySessionHandler:                       handler.NewVerifySessionHandler(authService, userByUserIDUsecase),
		FindUserByIDHandler:                        handler.NewFindUserByIDHandler(db),
		CreatePostHandler:                          handler.NewCreatePostHandler(updateNotificationUsecase, createPostUsecase),
		CreateRepostHandler:                        handler.NewCreateRepostHandler(db, updateNotificationUsecase),
		CreateQuoteRepostHandler:                   handler.NewCreateQuoteRepostHandler(db, updateNotificationUsecase),
		DeleteRepostHandler:                        handler.NewDeleteRepostHandler(db, updateNotificationUsecase),
		GetUserPostsTimelineHandler:                handler.NewGetUserPostsTimelineHandler(db),
		GetReverseChronologicalHomeTimelineHandler: handler.NewGetReverseChronologicalHomeTimelineHandler(db, updateNotificationUsecase, make(chan struct{}, 1)),
		CreateFollowshipHandler:                    handler.NewCreateFollowshipHandler(db),
	}
}
