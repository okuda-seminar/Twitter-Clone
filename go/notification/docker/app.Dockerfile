FROM golang:1.22

RUN apt-get update -qq && \
    apt-get install -y postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

WORKDIR /go/src/app
COPY go.mod go.sum ./
RUN go mod download && go mod verify
RUN go install -tags postgres github.com/golang-migrate/migrate/v4/cmd/migrate@latest
RUN go install goa.design/goa/v3/cmd/goa@v3
