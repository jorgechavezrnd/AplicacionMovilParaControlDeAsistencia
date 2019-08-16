package siaapresenter

import (
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaview"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetPersonPicturePresenter contains the view
type SIAAGetPersonPicturePresenter struct {
	View siaaview.SIAAGetPersonPictureView
}

// DisplayPicture send the picture with the view
func (siaaGetPersonPicturePresenter SIAAGetPersonPicturePresenter) DisplayPicture(response response.GetPersonPictureResponse) {
	model := siaaviewmodel.SIAAGetPersonPictureViewModel{
		PictureBytes: response.PictureBytes,
	}

	siaaGetPersonPicturePresenter.View.SendPicture(model)
}
