package controller

import (
	"database/sql"
	"os"

	"x-clone-backend/internal/application/service"
	usecaseInjector "x-clone-backend/internal/application/usecase/injector"
	"x-clone-backend/internal/controller/handler"
	infraInjector "x-clone-backend/internal/infrastructure/injector"
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
	timelineItemsRepository := infraInjector.InjectTimelineItemsRepository(db)
	usersRepository := infraInjector.InjectUsersRepository(db)

	secretKey := os.Getenv("SECRET_KEY")
	authService := service.NewAuthService(secretKey)

	createPostUsecase := usecaseInjector.InjectCreatePostUsecase(timelineItemsRepository)
	createUserUsecase := usecaseInjector.InjectCreateUserUsecase(usersRepository)
	followUserUsecase := usecaseInjector.InjectFollowUserUsecase(usersRepository)
	loginUsecase := usecaseInjector.InjectLoginUsecase(usersRepository, authService)
	specificUserPostsUsecase := usecaseInjector.InjectSpecificUserPostsUsecase(timelineItemsRepository)
	updateNotificationUsecase := usecaseInjector.InjectUpdateNotificationUsecase(usersRepository)
	userAndFolloweePostsUsecase := usecaseInjector.InjectUserAndFolloweePostsUsecase(timelineItemsRepository)
	userByUserIDUsecase := usecaseInjector.InjectUserByUserIDUsecase(usersRepository)

	return Server{
		CreateUserHandler:                          handler.NewCreateUserHandler(authService, createUserUsecase),
		LoginHandler:                               handler.NewLoginHandler(loginUsecase),
		VerifySessionHandler:                       handler.NewVerifySessionHandler(authService, userByUserIDUsecase),
		FindUserByIDHandler:                        handler.NewFindUserByIDHandler(userByUserIDUsecase),
		CreatePostHandler:                          handler.NewCreatePostHandler(updateNotificationUsecase, createPostUsecase),
		CreateRepostHandler:                        handler.NewCreateRepostHandler(db, updateNotificationUsecase),
		CreateQuoteRepostHandler:                   handler.NewCreateQuoteRepostHandler(db, updateNotificationUsecase),
		DeleteRepostHandler:                        handler.NewDeleteRepostHandler(db, updateNotificationUsecase),
		GetUserPostsTimelineHandler:                handler.NewGetUserPostsTimelineHandler(specificUserPostsUsecase),
		GetReverseChronologicalHomeTimelineHandler: handler.NewGetReverseChronologicalHomeTimelineHandler(userAndFolloweePostsUsecase, updateNotificationUsecase, make(chan struct{}, 1)),
		CreateFollowshipHandler:                    handler.NewCreateFollowshipHandler(followUserUsecase),
	}
}
