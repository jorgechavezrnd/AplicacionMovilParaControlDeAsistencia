package siaaview

import (
	"encoding/json"
	"net/http"

	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetSubjectsView contains the http response writer
type SIAAGetSubjectsView struct {
	Writer http.ResponseWriter
}

// SendSubjects send the viewmodel
func (siaaGetSubjectsView SIAAGetSubjectsView) SendSubjects(model siaaviewmodel.SIAAGetSubjectsViewModel) {
	json.NewEncoder(siaaGetSubjectsView.Writer).Encode(model)
}
