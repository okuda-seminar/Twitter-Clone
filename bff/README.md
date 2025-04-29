## Description

Starter repository using the [Nest](https://github.com/nestjs/nest) framework with TypeScript.

## Prerequisites

Set up the `serverless` framework for local deployment.
- Please create a Serverless account by following the steps in the [official documentation](https://www.serverless.com/framework/docs/getting-started).
- Please make sure to register your AWS credentials when deploying the BFF application to Lambda using `yarn start:prod` by following the steps in the [official documentation](https://www.serverless.com/framework/docs/providers/aws/guide/credentials).

## Project Setup

```bash
$ yarn install
```

## Compile and Run the Project

### Development

```bash
$ cp .env.local.sample .env
$ yarn build
$ yarn start
```

 TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/725
 - [BFF] Apply hot-reloading to yarn start:dev

### Production

* Set the base URL for your production API endpoint in `.env.sample`.

```bash
$ cp .env.sample .env
$ yarn build
$ yarn start:prod

# To stop the server
$ yarn stop:prod
```

## Run Tests

```bash
# Unit tests
$ yarn test

# End-to-end (e2e) tests
$ yarn test:e2e

# Test coverage
$ yarn test:cov
```
