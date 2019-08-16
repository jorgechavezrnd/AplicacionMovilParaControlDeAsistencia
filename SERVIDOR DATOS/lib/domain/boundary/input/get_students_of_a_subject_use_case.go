package input

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/request"

// GetStudentsOfASubjectUseCase ...
type GetStudentsOfASubjectUseCase interface {
	GetStudents(request request.GetStudentsOfASubjectRequest)
}
