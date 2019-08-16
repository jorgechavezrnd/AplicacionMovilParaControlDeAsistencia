package siaapresenter

import (
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaview"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaviewmodel"
)

// SIAAGetStudentsOfASubjectPresenter ...
type SIAAGetStudentsOfASubjectPresenter struct {
	View siaaview.SIAAGetStudentsOfASubjectView
}

// DisplayStudents ...
func (siaaGetStudentsOfASubjectPresenter SIAAGetStudentsOfASubjectPresenter) DisplayStudents(response response.GetStudentsOfASubjectResponse) {
	model := siaaviewmodel.SIAAGetStudentsOfASubjectViewModel{
		StudentSlice: response.StudentSlice,
	}

	siaaGetStudentsOfASubjectPresenter.View.SendStudents(model)
}
