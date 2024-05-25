FROM golang:1.22

WORKDIR /go/src/app
COPY . .
RUN go mod download && go mod verify
RUN go build ./cmd/users
ENTRYPOINT [ "./users" ]
