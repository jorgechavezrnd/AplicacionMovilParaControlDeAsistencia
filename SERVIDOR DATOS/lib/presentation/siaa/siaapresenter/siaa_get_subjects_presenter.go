package siaapresenter

import (
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaview"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetSubjectsPresenter contains the view
type SIAAGetSubjectsPresenter struct {
	View siaaview.SIAAGetSubjectsView
}

// DisplaySubjects send the subjects with the view
func (siaaGetSubjectsPresenter SIAAGetSubjectsPresenter) DisplaySubjects(response response.GetSubjectsResponse) {
	model := siaaviewmodel.SIAAGetSubjectsViewModel{
		SubjectSlice: response.SubjectSlice,
	}

	siaaGetSubjectsPresenter.View.SendSubjects(model)
}
