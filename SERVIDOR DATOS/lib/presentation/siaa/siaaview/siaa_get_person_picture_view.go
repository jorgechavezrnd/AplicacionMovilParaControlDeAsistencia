package siaaview

import (
	"net/http"

	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetPersonPictureView contains the http response writer
type SIAAGetPersonPictureView struct {
	Writer http.ResponseWriter
}

// SendPicture send the viewmodel
func (siaaGetPersonPictureView SIAAGetPersonPictureView) SendPicture(model siaaviewmodel.SIAAGetPersonPictureViewModel) {
	pictureBytes := model.PictureBytes

	siaaGetPersonPictureView.Writer.Write(pictureBytes)
}
