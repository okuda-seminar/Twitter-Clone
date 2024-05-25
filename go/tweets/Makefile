POSTGRES_SERVICE_NAME=tweets_postgres
APP_SERVICE_NAME=tweets_app
SERVICE_NAME=tweets_service

build:
	make down
	docker-compose build

up:
	docker-compose up -d

exec_app:
	docker-compose exec -it ${APP_SERVICE_NAME} bash

exec_pg:
	docker-compose exec -it ${POSTGRES_SERVICE_NAME} bash

down:
	docker-compose down --rmi all --volumes

stop:
	docker-compose stop

build_service:
	docker build -f ./docker/Dockerfile -t ${SERVICE_NAME} .

run_service:
	docker run --name=${SERVICE_NAME} ${SERVICE_NAME}
