package output

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"

// GetStudentsOfASubjectPresenter ...
type GetStudentsOfASubjectPresenter interface {
	DisplayStudents(response response.GetStudentsOfASubjectResponse)
}
