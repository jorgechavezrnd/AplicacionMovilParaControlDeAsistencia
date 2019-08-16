package ucbviewmodel

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"

// UCBGetSubjectsViewModel contains the subjects data
type UCBGetSubjectsViewModel struct {
	SubjectSlice []entities.Subject `json:"subjects"`
}
