package ucbpresenter

import (
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbview"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbviewmodel"
)

// UCBGetUserPresenter contains the view
type UCBGetUserPresenter struct {
	View ucbview.UCBGetUserView
}

// DisplayUser send the user with the view
func (ucbGetUserPresenter UCBGetUserPresenter) DisplayUser(response response.GetUserResponse) {
	model := ucbviewmodel.UCBGetUserViewModel{
		ID:       response.ID,
		Username: response.Username,
		Password: response.Password,
		Name:     response.Name,
	}

	ucbGetUserPresenter.View.SendUser(model)
}
