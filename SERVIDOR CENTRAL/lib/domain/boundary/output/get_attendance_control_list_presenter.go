package output

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"

// GetAttendanceControlListPresenter ...
type GetAttendanceControlListPresenter interface {
	DisplayAttendanceControlList(response response.GetAttendanceControlListResponse)
}
