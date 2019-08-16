package entitygateways

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"

// StudentRepository ...
type StudentRepository interface {
	FindStudents(subjectID string, paralelID string) []entities.Student
}
