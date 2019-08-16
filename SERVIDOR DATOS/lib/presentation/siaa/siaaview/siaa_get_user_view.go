package siaaview

import (
	"encoding/json"
	"net/http"

	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetUserView contains the http response writer
type SIAAGetUserView struct {
	Writer http.ResponseWriter
}

// SendUser send the viewmodel
func (siaaGetUserView SIAAGetUserView) SendUser(model siaaviewmodel.SIAAGetUserViewModel) {
	json.NewEncoder(siaaGetUserView.Writer).Encode(model)
}
