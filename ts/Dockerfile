FROM node:20.15.0

WORKDIR /app/twitter
COPY twitter/package.json ./

RUN yarn install
COPY ./twitter .
