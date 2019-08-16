package siaaviewmodel

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"

// SIAAGetSubjectsViewModel contains the subjects data
type SIAAGetSubjectsViewModel struct {
	SubjectSlice []entities.Subject `json:"subjects"`
}
