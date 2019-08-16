package interactors

import (
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/boundary/output"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entitygateways"
)

// GetPersonPictureInteractor is the implementation of the input boundary
type GetPersonPictureInteractor struct {
	Repository entitygateways.PictureRepository
	Output     output.GetPersonPicturePresenter
}

// GetPersonPicture find a picture by person id
func (getPersonPictureInteractor GetPersonPictureInteractor) GetPersonPicture(request request.GetPersonPictureRequest) {
	personID := request.PersonID
	picture := getPersonPictureInteractor.Repository.FindPicture(personID)
	getPersonPictureResponse := response.GetPersonPictureResponse{
		PictureBytes: picture.PictureBytes,
	}
	getPersonPictureInteractor.Output.DisplayPicture(getPersonPictureResponse)
}
