package usecase

type DeleteUserUsecase interface {
	DeleteUser(userID string) error
}
