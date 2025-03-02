FROM node:18-alpine

WORKDIR /app

RUN npm install -g @redocly/cli

CMD ["redocly", "bundle", "/openapi/openapi.yml", "-o", "/openapi/bundle/bundled-openapi.yml"]
