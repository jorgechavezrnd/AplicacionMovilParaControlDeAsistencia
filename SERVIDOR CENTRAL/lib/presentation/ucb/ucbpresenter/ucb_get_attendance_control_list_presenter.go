package ucbpresenter

import (
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbview"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbviewmodel"
)

// UCBGetAttendanceControlListPresenter ...
type UCBGetAttendanceControlListPresenter struct {
	View ucbview.UCBGetAttendanceControlListView
}

// DisplayAttendanceControlList ...
func (ucbGetAttendanceControlListPresenter UCBGetAttendanceControlListPresenter) DisplayAttendanceControlList(response response.GetAttendanceControlListResponse) {
	model := ucbviewmodel.UCBGetAttendanceControlListViewModel{
		StudentsPresentSlice:                   response.StudentsPresentSlice,
		StudentsMissingSlice:                   response.StudentsMissingSlice,
		NumberOfDoubtfulStudents:               response.NumberOfDoubtfulStudents,
		PictureWithFacesDetectedAndNamesBase64: response.PictureWithFacesDetectedAndNamesBase64,
	}

	ucbGetAttendanceControlListPresenter.View.SendAttendanceControlList(model)
}
