package output

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"

// GetSubjectsPresenter is the output boundary
type GetSubjectsPresenter interface {
	DisplaySubjects(response response.GetSubjectsResponse)
}
