package interactors

import (
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/boundary/output"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entitygateways"
)

// GetAttendanceControlListInteractor ...
type GetAttendanceControlListInteractor struct {
	Repository entitygateways.StudentRepository
	Output     output.GetAttendanceControlListPresenter
}

// GetAttendanceControlList ...
func (getAttendanceControlListInteractor GetAttendanceControlListInteractor) GetAttendanceControlList(request request.GetAttendanceControlListRequest) {
	subjectID := request.SubjectID
	paralelID := request.ParalelID
	ImageBase64 := request.ImageBase64
	attendanceControlList := getAttendanceControlListInteractor.Repository.FindStudents(ImageBase64, subjectID, paralelID)
	getAttendanceControlListResponse := response.GetAttendanceControlListResponse{
		StudentsPresentSlice:                   attendanceControlList.StudentsPresentSlice,
		StudentsMissingSlice:                   attendanceControlList.StudentsMissingSlice,
		NumberOfDoubtfulStudents:               attendanceControlList.NumberOfDoubtfulStudents,
		PictureWithFacesDetectedAndNamesBase64: attendanceControlList.PictureWithFacesDetectedAndNamesBase64,
	}
	getAttendanceControlListInteractor.Output.DisplayAttendanceControlList(getAttendanceControlListResponse)
}
