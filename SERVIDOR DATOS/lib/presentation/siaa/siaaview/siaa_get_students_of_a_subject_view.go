package siaaview

import (
	"encoding/json"
	"net/http"

	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetStudentsOfASubjectView ...
type SIAAGetStudentsOfASubjectView struct {
	Writer http.ResponseWriter
}

// SendStudents ...
func (siaaGetStudentsOfASubjectView SIAAGetStudentsOfASubjectView) SendStudents(model siaaviewmodel.SIAAGetStudentsOfASubjectViewModel) {
	json.NewEncoder(siaaGetStudentsOfASubjectView.Writer).Encode(model)
}
