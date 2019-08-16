package siaapresenter

import (
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaview"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetUserPresenter contains the view
type SIAAGetUserPresenter struct {
	View siaaview.SIAAGetUserView
}

// DisplayUser send the user with the view
func (siaaGetUserPresenter SIAAGetUserPresenter) DisplayUser(response response.GetUserResponse) {
	model := siaaviewmodel.SIAAGetUserViewModel{
		ID:       response.ID,
		Username: response.Username,
		Password: response.Password,
		Name:     response.Name,
	}

	siaaGetUserPresenter.View.SendUser(model)
}
