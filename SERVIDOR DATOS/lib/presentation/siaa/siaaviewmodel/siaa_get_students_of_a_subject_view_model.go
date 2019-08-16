package siaaviewmodel

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"

// SIAAGetStudentsOfASubjectViewModel ...
type SIAAGetStudentsOfASubjectViewModel struct {
	StudentSlice []entities.Student `json:"students_list"`
}
