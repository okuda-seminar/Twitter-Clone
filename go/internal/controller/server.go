package controller

import (
	"database/sql"
	"os"

	"github.com/redis/go-redis/v9"

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
	handler.DeleteUserByIDHandler
	handler.CreatePostHandler
	handler.DeletePostHandler
	handler.CreateRepostHandler
	handler.CreateQuoteRepostHandler
	handler.DeleteRepostHandler
	handler.GetUserPostsTimelineHandler
	handler.GetReverseChronologicalHomeTimelineHandler
	handler.CreateFollowshipHandler
	handler.DeleteFollowshipHandler
	handler.LikePostHandler
	handler.UnlikePostHandler
	handler.MuteUserHandler
	handler.UnmuteUserHandler
	handler.BlockUserHandler
	handler.UnblockUserHandler
	handler.GetPostByPostIDHandler
	handler.GetFolloweesByIDHandler
	handler.GetFollowersByIDHandler
}

func NewServer(db *sql.DB, client *redis.Client) Server {
	timelineItemsRepository := infraInjector.InjectTimelineItemsRepository(db, client)
	usersRepository := infraInjector.InjectUsersRepository(db)

	secretKey := os.Getenv("SECRET_KEY")
	authService := service.NewAuthService(secretKey)

	blockUserUsecase := usecaseInjector.InjectBlockUserUsecase(usersRepository)
	createPostUsecase := usecaseInjector.InjectCreatePostUsecase(timelineItemsRepository, usersRepository)
	createQuoteRepostUsecase := usecaseInjector.InjectCreateQuoteRepostUsecase(timelineItemsRepository, usersRepository)
	createRepostUsecase := usecaseInjector.InjectCreateRepostUsecase(timelineItemsRepository, usersRepository)
	createUserUsecase := usecaseInjector.InjectCreateUserUsecase(usersRepository)
	deletePostUsecase := usecaseInjector.InjectDeletePostUsecase(timelineItemsRepository)
	deleteRepostUsecase := usecaseInjector.InjectDeleteRepostUsecase(timelineItemsRepository)
	deleteUserByIDUsecase := usecaseInjector.InjectDeleteUserByIDUsecase(usersRepository)
	followUserUsecase := usecaseInjector.InjectFollowUserUsecase(usersRepository)
	unfollowUserUsecase := usecaseInjector.InjectUnfollowUserUsecase(usersRepository)
	likePostUsecase := usecaseInjector.InjectLikePostUsecase(usersRepository)
	loginUsecase := usecaseInjector.InjectLoginUsecase(usersRepository, authService)
	muteUserUsecase := usecaseInjector.InjectMuteUserUsecase(usersRepository)
	specificUserPostsUsecase := usecaseInjector.InjectSpecificUserPostsUsecase(timelineItemsRepository)
	unblockUserUsecase := usecaseInjector.InjectUnblockUserUsecase(usersRepository)
	unlikePostUsecase := usecaseInjector.InjectUnlikePostUsecase(usersRepository)
	unmuteUserUsecase := usecaseInjector.InjectUnmuteUserUsecase(usersRepository)
	userAndFolloweePostsUsecase := usecaseInjector.InjectUserAndFolloweePostsUsecase(timelineItemsRepository)
	userByUserIDUsecase := usecaseInjector.InjectUserByUserIDUsecase(usersRepository)
	getPostByPostIDUsecase := usecaseInjector.InjectGetPostByPostIDUsecase(&timelineItemsRepository)
	getFolloweesByIDUsecase := usecaseInjector.InjectGetFolloweesByIDUsecase(usersRepository)
	getFollowersByIDUsecase := usecaseInjector.InjectGetFollowersByIDUsecase(usersRepository)

	return Server{
		CreateUserHandler:                          handler.NewCreateUserHandler(authService, createUserUsecase),
		LoginHandler:                               handler.NewLoginHandler(loginUsecase),
		VerifySessionHandler:                       handler.NewVerifySessionHandler(authService, userByUserIDUsecase),
		FindUserByIDHandler:                        handler.NewFindUserByIDHandler(userByUserIDUsecase),
		DeleteUserByIDHandler:                      handler.NewDeleteUserByIDHandler(deleteUserByIDUsecase),
		CreatePostHandler:                          handler.NewCreatePostHandler(createPostUsecase),
		DeletePostHandler:                          handler.NewDeletePostHandler(deletePostUsecase),
		CreateRepostHandler:                        handler.NewCreateRepostHandler(createRepostUsecase),
		CreateQuoteRepostHandler:                   handler.NewCreateQuoteRepostHandler(createQuoteRepostUsecase),
		DeleteRepostHandler:                        handler.NewDeleteRepostHandler(deleteRepostUsecase),
		GetUserPostsTimelineHandler:                handler.NewGetUserPostsTimelineHandler(specificUserPostsUsecase),
		GetReverseChronologicalHomeTimelineHandler: handler.NewGetReverseChronologicalHomeTimelineHandler(userAndFolloweePostsUsecase),
		CreateFollowshipHandler:                    handler.NewCreateFollowshipHandler(followUserUsecase),
		DeleteFollowshipHandler:                    handler.NewDeleteFollowshipHandler(unfollowUserUsecase),
		LikePostHandler:                            handler.NewLikePostHandler(likePostUsecase),
		UnlikePostHandler:                          handler.NewUnlikePostHandler(unlikePostUsecase),
		MuteUserHandler:                            handler.NewMuteUserHandler(muteUserUsecase),
		UnmuteUserHandler:                          handler.NewUnmuteUserHandler(unmuteUserUsecase),
		BlockUserHandler:                           handler.NewBlockUserHandler(blockUserUsecase),
		UnblockUserHandler:                         handler.NewUnblockUserHandler(unblockUserUsecase),
		GetPostByPostIDHandler:                     handler.NewGetPostByPostIDHandler(getPostByPostIDUsecase),
		GetFolloweesByIDHandler:                    handler.NewGetFolloweesByIDHandler(getFolloweesByIDUsecase),
		GetFollowersByIDHandler:                    handler.NewGetFollowersByIDHandler(getFollowersByIDUsecase),
	}
}
