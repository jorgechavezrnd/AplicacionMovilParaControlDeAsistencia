package output

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/response"

// GetUserPresenter is the output boundary
type GetUserPresenter interface {
	DisplayUser(response response.GetUserResponse)
}
