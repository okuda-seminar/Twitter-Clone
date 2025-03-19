package handler

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"sync"
	"testing"

	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/ory/dockertest"
	"github.com/ory/dockertest/docker"
	"github.com/stretchr/testify/suite"

	"x-clone-backend/internal/application/service"
	"x-clone-backend/internal/application/usecase"
	"x-clone-backend/internal/application/usecase/interactor"
	"x-clone-backend/internal/domain/repository"
	"x-clone-backend/internal/domain/value"
	"x-clone-backend/internal/infrastructure/persistence"
)

const (
	host     = "localhost"
	user     = "postgres"
	password = "postgres"
	dbname   = "handler_test"
	port     = "5435"
	dsn      = "host=%s port=%s user=%s password=%s dbname=%s sslmode=disable timezone=UTC connect_timeout=5"

	migrationFilesPath = "../../../db/migrations"
)

var (
	opts dockertest.RunOptions
	pool *dockertest.Pool
)

func TestMain(m *testing.M) {
	var err error

	// connect to Docker.
	pool, err = dockertest.NewPool("")
	if err != nil {
		log.Fatalf("Could not construct pool: %s", err)
	}

	// set up our docker options, specifying the image and so forth.
	opts = dockertest.RunOptions{
		Repository: "postgres",
		Tag:        "14.5",
		Env: []string{
			"POSTGRES_USER=" + user,
			"POSTGRES_PASSWORD=" + password,
			"POSTGRES_DB=" + dbname,
		},
		ExposedPorts: []string{"5432"},
		PortBindings: map[docker.Port][]docker.PortBinding{
			"5432": {
				{HostIP: "0.0.0.0", HostPort: port},
			},
		},
	}

	// run tests.
	code := m.Run()

	os.Exit(code)
}

type handlerTestSuite struct {
	suite.Suite
	db                             *sql.DB
	resource                       *dockertest.Resource
	getSpecificUserPostsUsecase    usecase.GetSpecificUserPostsUsecase
	specificUserPostsUsecase       usecase.SpecificUserPostsUsecase
	loginUseCase                   usecase.LoginUsecase
	getUserAndFolloweePostsUsecase usecase.GetUserAndFolloweePostsUsecase
	userAndFolloweePostsUsecase    usecase.UserAndFolloweePostsUsecase
	usersRepository                repository.UsersRepository
	createUserUsecase              usecase.CreateUserUsecase
	authService                    *service.AuthService
	likePostUsecase                usecase.LikePostUsecase
	unlikePostUsecase              usecase.UnlikePostUsecase
	followUserUsecase              usecase.FollowUserUsecase
	muteUserUsecase                usecase.MuteUserUsecase
	userChannels                   map[string]chan value.TimelineEvent
	mu                             sync.Mutex
	connected                      chan struct{}
}

// SetupTest runs before each test in the suite.
func (s *handlerTestSuite) SetupTest() {
	var err error

	// pulls an image, creates a container based on it and runs it.
	s.resource, err = pool.RunWithOptions(&opts)
	if err != nil {
		log.Fatalf("Could not start resource: %s", err)
	}

	// exponential backoff-retry, because the application in the container
	// might not be ready to accept connections yet.
	if err := pool.Retry(func() error {
		var err error
		s.db, err = sql.Open("pgx", fmt.Sprintf(dsn, host, port, user, password, dbname))
		if err != nil {
			return err
		}
		return s.db.Ping()
	}); err != nil {
		log.Fatalf("Could not connect to database: %s", err)
	}

	// populate the database with empty tables.
	driver, err := postgres.WithInstance(s.db, &postgres.Config{})
	if err != nil {
		log.Fatalln(err)
	}
	m, err := migrate.NewWithDatabaseInstance(fmt.Sprintf("file://%s", migrationFilesPath), dbname, driver)
	if err != nil {
		log.Fatalln(err)
	}

	secretKey := "test_secret_key"
	s.authService = service.NewAuthService(secretKey)

	// Set up usecases.
	postsRepository := persistence.NewPostsRepository(s.db)
	s.getSpecificUserPostsUsecase = interactor.NewGetSpecificUserPostsUsecase(postsRepository)
	s.loginUseCase = interactor.NewLoginUseCase(s.usersRepository, s.authService)
	s.getUserAndFolloweePostsUsecase = interactor.NewGetUserAndFolloweePostsUsecase(postsRepository)

	timelineitemsRepository := persistence.NewTimelineitemsRepository(s.db)
	s.specificUserPostsUsecase = interactor.NewSpecificUserPostsUsecase(timelineitemsRepository)
	s.userAndFolloweePostsUsecase = interactor.NewUserAndFolloweePostsUsecase(timelineitemsRepository)

	s.usersRepository = persistence.NewUsersRepository(s.db)
	s.createUserUsecase = interactor.NewCreateUserUsecase(s.usersRepository)
	s.likePostUsecase = interactor.NewLikePostUsecase(s.usersRepository)
	s.unlikePostUsecase = interactor.NewUnlikePostUsecase(s.usersRepository)
	s.followUserUsecase = interactor.NewFollowUserUsecase(s.usersRepository)
	s.muteUserUsecase = interactor.NewMuteUserUsecase(s.usersRepository)

	s.mu = sync.Mutex{}
	s.userChannels = make(map[string]chan value.TimelineEvent)

	s.connected = make(chan struct{})

	m.Up()
}

// TearDownTest runs after each test in the suite.
func (s *handlerTestSuite) TearDownTest() {
	s.db.Close()

	if err := pool.Purge(s.resource); err != nil {
		log.Fatalf("Could not purge resource: %s", err)
	}
}
