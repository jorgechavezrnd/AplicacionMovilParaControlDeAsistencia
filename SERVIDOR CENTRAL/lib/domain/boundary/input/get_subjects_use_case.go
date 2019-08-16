package input

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"

// GetSubjectsUseCase is the input boundary
type GetSubjectsUseCase interface {
	GetSubjects(request request.GetSubjectsRequest)
}
