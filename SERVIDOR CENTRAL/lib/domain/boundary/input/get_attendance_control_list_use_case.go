package input

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"

// GetAttendanceControlListUseCase ...
type GetAttendanceControlListUseCase interface {
	GetAttendanceControlList(request request.GetAttendanceControlListRequest)
}
