package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"sync"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/config"
	"x-clone-backend/internal/controller"
	"x-clone-backend/internal/controller/handler"
	"x-clone-backend/internal/controller/middleware"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/infrastructure/persistence"
	"x-clone-backend/internal/openapi"
)

const (
	port = 80
)

func main() {
	secretKey := os.Getenv("SECRET_KEY")
	db, err := config.ConnectToPostgres()
	if err != nil {
		log.Fatalln(err)
	}
	defer db.Close()

	var userChannels = make(map[string]chan entity.TimelineEvent)
	var mu sync.Mutex

	authService := service.NewAuthService(secretKey)

	server := controller.NewServer(db, &mu, &userChannels, authService)
	mux := http.NewServeMux()

	usersRepository := persistence.NewUsersRepository(db)
	deleteUserUsecase := interactor.NewDeleteUserUsecase(usersRepository)
	likePostUsecase := interactor.NewLikePostUsecase(usersRepository)
	unlikePostUsecase := interactor.NewUnlikePostUsecase(usersRepository)
	unfollowUserUsecase := interactor.NewUnfollowUserUsecase(usersRepository)
	muteUserUsecase := interactor.NewMuteUserUsecase(usersRepository)
	unmuteUserUsecase := interactor.NewUnmuteUserUsecase(usersRepository)
	blockUserUsecase := interactor.NewBlockUserUsecase(usersRepository)
	unblockUserUsecase := interactor.NewUnblockUserUsecase(usersRepository)

	mux.HandleFunc("DELETE /api/posts/{postID}", func(w http.ResponseWriter, r *http.Request) {
		handler.DeletePost(w, r, db, &mu, &userChannels)
	})

	mux.HandleFunc("DELETE /api/users/{userID}", func(w http.ResponseWriter, r *http.Request) {
		handler.DeleteUserByID(w, r, deleteUserUsecase)
	})

	mux.HandleFunc("POST /api/users/{id}/likes", func(w http.ResponseWriter, r *http.Request) {
		handler.LikePost(w, r, likePostUsecase)
	})

	mux.HandleFunc("DELETE /api/users/{id}/likes/{post_id}", func(w http.ResponseWriter, r *http.Request) {
		handler.UnlikePost(w, r, unlikePostUsecase)
	})

	mux.HandleFunc("DELETE /api/users/{source_user_id}/following/{target_user_id}", func(w http.ResponseWriter, r *http.Request) {
		handler.DeleteFollowship(w, r, unfollowUserUsecase)
	})

	mux.HandleFunc("POST /api/users/{id}/muting", func(w http.ResponseWriter, r *http.Request) {
		handler.CreateMuting(w, r, muteUserUsecase)
	})

	mux.HandleFunc("DELETE /api/users/{source_user_id}/muting/{target_user_id}", func(w http.ResponseWriter, r *http.Request) {
		handler.DeleteMuting(w, r, unmuteUserUsecase)
	})

	mux.HandleFunc("POST /api/users/{id}/blocking", func(w http.ResponseWriter, r *http.Request) {
		handler.CreateBlocking(w, r, blockUserUsecase)
	})

	mux.HandleFunc("DELETE /api/users/{source_user_id}/blocking/{target_user_id}", func(w http.ResponseWriter, r *http.Request) {
		handler.DeleteBlocking(w, r, unblockUserUsecase)
	})

	mux.HandleFunc("/api/notifications", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Notifications\n")
	})

	handler := middleware.CORS(openapi.HandlerFromMux(&server, mux))
	s := http.Server{
		Handler: handler,
		Addr:    fmt.Sprintf(":%d", port),
	}

	log.Println("Starting server...")

	err = s.ListenAndServe()
	if err != nil {
		log.Fatalln(err)
	}
}
