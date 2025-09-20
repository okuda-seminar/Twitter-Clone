# X-Clone-Backend
## Building the Environment
To set up the development environment, follow these steps:

1. Build Docker image  

Make sure you have Docker installed on your machine.
```
make build
```

2. Start Docker Containers

Start the Docker containers using docker-compose:
```
make up
```


If the container launches successfully, the server will be built in `/tmp/server` and the backend server will start automatically. If the build fails, refer to `/tmp/build-errors.log` to identify the cause.

## Checking PostgreSQL State
To check the state of the PostgreSQL database:

1. Access the PostgreSQL Container  

Enter the PostgreSQL container:
```
make exec-pg
```

2. Connect to the PostgreSQL Database

Once inside the PostgreSQL container, connect to the database:
```
psql
```

3. Check the Database State

You can now run SQL commands to check the state of the database. For example, to list all tables:
```
\dt
```
To view the contents of a table:
```
SELECT * FROM [table_name];
```

## Migration Guide
To add a new schema migration:

1. Create Migration Files

Run the following command inside the application container to create new migration files:

```
migrate create -ext sql -seq -dir ./db/migrations [migration_name]
```
This will generate two SQL files: one for the up migration and one for the down migration.

2. Edit Migration Files

Write the SQL statements in the generated files. For example, to create a new table, add the SQL to the up migration file.


## OpenAPI
### Why We Use OpenAPI
OpenAPI standardizes API definitions, ensuring consistency and enabling automation in code generation, documentation, and validation. It simplifies integration with external tools and services while reducing manual effort in maintaining API specifications.

### Sample Commits
You can refer to the following commits as examples of how to add and implement new APIs using OpenAPI:
- [[Go] Implement Login Handler and Usecase for User Authentication](https://github.com/okuda-seminar/Twitter-Clone/pull/592/commits/088a88adada6369c26856c84cc0402ab49a4d3ca)
- [[Go] Implement reposts using a naive approach](https://github.com/okuda-seminar/Twitter-Clone/pull/593/commits/6ba778cc7a6e75cbc2282ca3de18a80a8d83b6ac)

### How to Add a New API
1. Define the New API in OpenAPI YAML<br />
    To add a new API, modify the OpenAPI schema files inside the `openapi` directory at the project root. Define the new endpoint, including request parameters, response structure, and possible error cases.

2. Re-bundle the OpenAPI Schema<br />
    The Twitter-Clone project uses `redocly` inside a Docker container to bundle the OpenAPI schema. To bundle the schema, run:
    ```sh
    make bundle-openapi
    ```

### Implementation Flow
1. Generate Go Code<br />
    To generate Go code from the OpenAPI schema, the project uses the `oapi-codegen` tool. Run:
    ```sh
    make generate-code-from-openapi
    ```
    This generates the necessary Go files (`models.gen.go` and `server.gen.go`) based on the OpenAPI definitions.

2. Implement the API Logic<br />
    1. Create a new handler in `internal/controller/handler`.
    2. Implement the logic for processing requests and returning responses.
    3. Register the handler with the router by embedding it into the `Server` struct in `internal/controller/server.go`.

### View API Documentation in a Browser
After bundling, you can view the API documentation in your browser:
1. Visit [ReDoc](https://redocly.github.io/redoc/).
2. Upload `bundled-openapi.yml` from `Twitter-Clone/openapi/bundle`.

## Discussion Points
- [ ] Monolith vs Modular Monolith vs Microservices
- [X] Mocking Database vs Running it with Docker
    - [How we made PostgreSQL work in unit tests](https://engblog.nirvanatech.com/how-to-run-unit-tests-on-production-data-using-golang-postgresql-f2ebf38a3271)
- [ ] Graceful Shutdown
  - [【Go】HTTPサーバーは安全に終了させましょう](https://zenn.dev/tksx1227/articles/5ab5b3c99336c3)
- [ ] Connection Pooling
- [ ] Physical Delete vs Logical Delete
- [ ] Upgrading code and DB schema without downtime
- [ ] REST vs GraphQL
- [ ] ent.
- [ ] How to handle repost
