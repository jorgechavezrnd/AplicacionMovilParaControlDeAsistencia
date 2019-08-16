package entitygateways

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"

// SubjectRepository is the entity gateway
type SubjectRepository interface {
	FindSubjects(userID string) []entities.Subject
}
