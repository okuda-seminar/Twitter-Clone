package fake

import (
	"time"

	"github.com/google/uuid"

	usecase "x-clone-backend/internal/application/usecase/api"
	"x-clone-backend/internal/domain/entity"
	"x-clone-backend/internal/domain/value"
)

type fakeCreateRepostUsecase struct {
	err error
}

func NewFakeCreateRepostUsecase() usecase.CreateRepostUsecase {
	return &fakeCreateRepostUsecase{
		err: nil,
	}
}

func (u *fakeCreateRepostUsecase) CreateRepost(userID, postID string) (entity.TimelineItem, error) {
	if u.err != nil {
		return entity.TimelineItem{}, u.err
	}

	repost := entity.TimelineItem{
		Type:         entity.PostTypeRepost,
		ID:           uuid.NewString(),
		AuthorID:     userID,
		ParentPostID: value.NullUUID{UUID: postID, Valid: true},
		Text:         "",
		CreatedAt:    time.Now(),
	}

	return repost, nil
}

func (u *fakeCreateRepostUsecase) SetError(err error) {
	u.err = err
}

func (u *fakeCreateRepostUsecase) ClearError() {
	u.err = nil
}
