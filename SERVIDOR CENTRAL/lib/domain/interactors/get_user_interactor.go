package interactors

import (
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/boundary/output"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entitygateways"
)

// GetUserInteractor is the implementation of the input boundary
type GetUserInteractor struct {
	Repository entitygateways.UserRepository
	Output     output.GetUserPresenter
}

// GetUser find a user by username
func (getUserInteractor GetUserInteractor) GetUser(request request.GetUserRequest) {
	username := request.Username
	user := getUserInteractor.Repository.FindUser(username)
	getUserResponse := response.GetUserResponse{
		ID:       user.ID,
		Username: user.Username,
		Password: user.Password,
		Name:     user.Name,
	}
	getUserInteractor.Output.DisplayUser(getUserResponse)
}
