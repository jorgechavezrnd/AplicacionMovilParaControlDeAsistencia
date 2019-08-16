package input

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/request"

// GetPersonPictureUseCase is the input boundary
type GetPersonPictureUseCase interface {
	GetPersonPicture(request request.GetPersonPictureRequest)
}
