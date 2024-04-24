# TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/92 - Introduce docker-compose.
FROM node:latest as builder

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
