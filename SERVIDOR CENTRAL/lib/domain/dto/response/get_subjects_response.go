package response

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"

// GetSubjectsResponse contains subject list
type GetSubjectsResponse struct {
	SubjectSlice []entities.Subject `json:"subjects"`
}
