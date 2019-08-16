package interactors

import (
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/boundary/output"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entitygateways"
)

// GetStudentsOfASubjectInteractor ...
type GetStudentsOfASubjectInteractor struct {
	Repository entitygateways.StudentRepository
	Output     output.GetStudentsOfASubjectPresenter
}

// GetStudents ...
func (getStudentsOfASubjectInteractor GetStudentsOfASubjectInteractor) GetStudents(request request.GetStudentsOfASubjectRequest) {
	subjectID := request.SubjectID
	paralelID := request.ParalelID
	studentSlice := getStudentsOfASubjectInteractor.Repository.FindStudents(subjectID, paralelID)
	getSubjectsResponse := response.GetStudentsOfASubjectResponse{
		StudentSlice: studentSlice,
	}
	getStudentsOfASubjectInteractor.Output.DisplayStudents(getSubjectsResponse)
}
