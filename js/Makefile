IMAGE_NAME = twitter-clone-web
CONTAINER_NAME = twitter-clone-js-container

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -p 3000:3000 --name $(CONTAINER_NAME) -d $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)

clean:
	docker rm $(CONTAINER_NAME)

start:
	make build
	make run

debug:
	make build
	make run
	docker logs -f $(CONTAINER_NAME)

.PHONY: default
default: start
