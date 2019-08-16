package input

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"

// GetUserUseCase is the input boundary
type GetUserUseCase interface {
	GetUser(request request.GetUserRequest)
}
