package output

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"

// GetPersonPicturePresenter is the output boundary
type GetPersonPicturePresenter interface {
	DisplayPicture(response response.GetPersonPictureResponse)
}
