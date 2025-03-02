FROM golang:1.22

RUN apt-get update -qq && \
    apt-get install -y postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

WORKDIR /go/src/app
COPY . .
RUN go mod download && go mod verify
RUN go install -tags postgres github.com/golang-migrate/migrate/v4/cmd/migrate@latest
RUN go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
