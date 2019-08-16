package entitygateways

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"

// StudentRepository ...
type StudentRepository interface {
	FindStudents(imageBase64 string, subjectID string, paralelID string) entities.AttendanceControlList
}
