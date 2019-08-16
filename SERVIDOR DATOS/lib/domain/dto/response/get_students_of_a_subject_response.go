package response

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"

// GetStudentsOfASubjectResponse ...
type GetStudentsOfASubjectResponse struct {
	StudentSlice []entities.Student `json:"student_list"`
}
