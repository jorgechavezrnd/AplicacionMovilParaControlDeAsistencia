package ucbpresenter

import (
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbview"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbviewmodel"
)

// UCBGetSubjectsPresenter contains the view
type UCBGetSubjectsPresenter struct {
	View ucbview.UCBGetSubjectsView
}

// DisplaySubjects send the subjects with the view
func (ucbGetSubjectsPresenter UCBGetSubjectsPresenter) DisplaySubjects(response response.GetSubjectsResponse) {
	model := ucbviewmodel.UCBGetSubjectsViewModel{
		SubjectSlice: response.SubjectSlice,
	}

	ucbGetSubjectsPresenter.View.SendSubjects(model)
}
