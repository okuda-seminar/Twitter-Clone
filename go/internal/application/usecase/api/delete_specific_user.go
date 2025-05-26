package api

type DeleteUserUsecase interface {
	DeleteUser(userID string) error
}
