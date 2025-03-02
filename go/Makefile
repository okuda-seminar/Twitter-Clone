POSTGRES_SERVER_NAME=x_postgres
APP_SERVER_NAME=x_app
SERVER_NAME=x_backend

build:
	make down
	docker compose build

up:
	docker compose up -d

exec-app:
	docker compose exec -it ${APP_SERVER_NAME} bash

exec-pg:
	docker compose exec -it ${POSTGRES_SERVER_NAME} bash

down:
	docker compose down --rmi all --volumes

start:
	docker compose start

stop:
	docker compose stop

build-server:
	docker build -f ./docker/Dockerfile -t ${SERVER_NAME} .

run-server:
	docker run --name=${SERVER_NAME} ${SERVER_NAME}

stop-server:
	docker stop ${SERVER_NAME}

bundle-openapi:
	docker build -f ./docker/redocly.Dockerfile -t redocly-bundle .
	docker run --rm -v $(shell pwd)/../openapi:/openapi redocly-bundle

generate-code-from-openapi: start
	make bundle-openapi
	docker compose exec ${APP_SERVER_NAME} oapi-codegen -config ./config/oapi_server_config.yml openapi/bundle/bundled-openapi.yml
	docker compose exec ${APP_SERVER_NAME} oapi-codegen -config ./config/oapi_models_config.yml openapi/bundle/bundled-openapi.yml
