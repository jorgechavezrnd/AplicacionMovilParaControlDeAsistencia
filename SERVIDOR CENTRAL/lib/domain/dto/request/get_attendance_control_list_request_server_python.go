package request

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"

//GetAttendanceControlListServerPythonRequest ...
type GetAttendanceControlListServerPythonRequest struct {
	StudentsList []entities.Student `json:"students_list"`
}
