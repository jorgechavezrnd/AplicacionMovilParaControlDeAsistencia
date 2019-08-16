package interactors

import (
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/boundary/output"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entitygateways"
)

// GetSubjectsInteractor is the implementation of the input boundary
type GetSubjectsInteractor struct {
	Repository entitygateways.SubjectRepository
	Output     output.GetSubjectsPresenter
}

// GetSubjects find subjects by user id
func (getSubjectsInteractor GetSubjectsInteractor) GetSubjects(request request.GetSubjectsRequest) {
	userID := request.UserID
	subjectSlice := getSubjectsInteractor.Repository.FindSubjects(userID)
	getSubjectsResponse := response.GetSubjectsResponse{
		SubjectSlice: subjectSlice,
	}
	getSubjectsInteractor.Output.DisplaySubjects(getSubjectsResponse)
}
