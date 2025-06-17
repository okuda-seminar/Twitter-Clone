package main

import (
	"fmt"
	"log"
	"net/http"

	"x-clone-backend/internal/config"
	"x-clone-backend/internal/controller"
	"x-clone-backend/internal/controller/middleware"
	"x-clone-backend/internal/openapi"
)

const (
	port = 80
)

func main() {
	db, err := config.ConnectToPostgres()
	if err != nil {
		log.Fatalln(err)
	}
	defer db.Close()

	server := controller.NewServer(db)
	handler := openapi.HandlerWithOptions(
		&server,
		openapi.StdHTTPServerOptions{
			BaseURL: "/api",
			Middlewares: []openapi.MiddlewareFunc{
				middleware.CORS,
			},
		},
	)

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
